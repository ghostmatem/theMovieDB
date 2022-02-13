import 'dart:async';
import 'dart:io';
import 'request_api_arguments.dart';


class BaseAPIClient {
  BaseAPIClient({SecurityContext? context}) {
    _httpClient = HttpClient(context: context);
  }
  
  late final HttpClient _httpClient;

  Uri makeUri(
    String host, 
    String path, 
    [Map<String, dynamic>? parametrs]) {

    final Uri uri = Uri.parse('$host$path');
    if (parametrs == null) return uri;
    return uri.replace(queryParameters: parametrs);
  }

  Future<T> get<T>(RequestAPIArguments<T> args) async {
    final request = await _httpClient.getUrl(args.url);
    _addHeadersIfNeed(args, request);
    return await _getResponseResult(
      response: await request.close(),
      args: args
    );
  }

  Future<T> post<T>({
      required RequestAPIArguments<T> args, 
      required dynamic content,
    }) => _changeRequest(
        method: _httpClient.postUrl,
        content: content,
        args: args
  );
   
  Future<T> put<T>({
      required RequestAPIArguments<T> args, 
      required dynamic content,
    }) => _changeRequest(
      method: _httpClient.putUrl,
      content: content,
      args: args
  );
  
  Future<T> patch<T>({
      required RequestAPIArguments<T> args, 
      required dynamic content,
    }) => _changeRequest(
      method: _httpClient.patchUrl,
      content: content,
      args: args
  );
  
  Future<T> delete<T>(RequestAPIArguments<T> args) async {
    final request = await _httpClient.deleteUrl(args.url);
    return await _getResponseResult(
      response: await request.close(),
      args: args
    );
  }

  Future<T> _changeRequest<T>({
      required RequestAPIArguments<T> args,
      required Future<HttpClientRequest> Function(Uri url) method,
      required dynamic content,
    }) async {
    final request = await method(args.url);
    _addHeadersIfNeed(args, request);
    request.write(args.typeHandler.requestBodyEncoder(content));
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
    
    final result = args.responseHandler.contentParser(contentDecoded);

    final validator = args.responseHandler.validator;
    if (validator != null) validator(response, result);
    
    return result;
  }

  void _addHeadersIfNeed(
    RequestAPIArguments args, 
    HttpClientRequest request) {

    if (!args.needHeaders) return; 

    request.headers.contentType = args.typeHandler.contentType;

    if (args.headers == null) return;

    args.headers!.forEach((key, value) {
      request.headers.add(key, value);
    });
  }
}