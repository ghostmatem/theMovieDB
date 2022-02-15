import 'dart:async';
import 'dart:io';
import 'http_method.dart';
import 'request_api_arguments.dart';


class BaseAPIClient {
  BaseAPIClient({SecurityContext? context}) {
    final _httpClient = HttpClient(context: context);

    _methodMap = {
      HttpMethod.get : _httpClient.getUrl,
      HttpMethod.post : _httpClient.postUrl,
      HttpMethod.put : _httpClient.putUrl,
      HttpMethod.patch : _httpClient.patchUrl,
      HttpMethod.delete : _httpClient.deleteUrl,
    };
  }
  
  Uri makeUri(
    String host, 
    String path, 
    [Map<String, dynamic>? parametrs]) {

    final Uri uri = Uri.parse('$host$path');
    if (parametrs == null) return uri;
    return uri.replace(
      queryParameters: parametrs);
  }

  Future<T> sendRequest<T>({
      required HttpMethod httpMethod,
      required RequestAPIArguments<T> args,    
      dynamic requestBody,
    }) async {
      
    final method = _methodMap[httpMethod]!;
    // SocketException
    final request = await method(args.url);

    _addHeadersIfNeed(args, request);

    if (requestBody != null) {
      request.write(args.requestEncoder.requestBodyEncoder(requestBody));
    }

    return await _getResponseResult(
      response: await request.close(),
      args: args
    );
  }

  Future<T> _getResponseResult <T>({
      required RequestAPIArguments<T> args,
      required HttpClientResponse response,   
    }) async {

    final contentDecoded = await args.responseHandler
    .streamDecoder(response);
    
    final validator = args.responseHandler.validator;
    if (validator != null) validator(response, contentDecoded);

    final result = args.responseHandler.contentParser(contentDecoded);
    
    return result;
  }

  void _addHeadersIfNeed(
    RequestAPIArguments args, 
    HttpClientRequest request) {

    if (!args.needHeaders) return; 

    request.headers.contentType = args.requestEncoder.contentType;

    if (args.headers == null) return;

    args.headers!.forEach((key, value) {
      request.headers.add(key, value);
    });
  }

  // На данный момент не используется внутри класса, только в конструкторе
  late final HttpClient _httpClient;
  late final Map<HttpMethod, Future<HttpClientRequest> Function(Uri)> _methodMap;
}