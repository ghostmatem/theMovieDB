import 'api_handler.dart';

class RequestAPIArguments<T> {
  final Uri url;
  late final RequestEncoder requestEncoder;
  bool needHeaders;
  final Map<String, dynamic>? headers; 
  ResponseHandler<T> responseHandler;
  

  /// By default, requestEncoder.jsonUTF8
  RequestAPIArguments({ 
    required this.url,
    required this.responseHandler,
    RequestEncoder? requestEncoder,
    this.needHeaders = true,
    this.headers,
  }) {
    this.requestEncoder = requestEncoder ?? RequestEncoder.jsonUTF8;
  }
}