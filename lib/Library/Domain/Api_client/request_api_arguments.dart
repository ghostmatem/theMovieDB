import 'api_handler.dart';

class RequestAPIArguments<T> {
  final Uri url;
  late final RequestTypeHandler typeHandler;
  bool needHeaders;
  final Map<String, dynamic>? headers; 
  ResponseHandler<T> responseHandler;
  

  /// By default, typeHandler.jsonUTF8
  RequestAPIArguments({ 
    required this.url,
    required this.responseHandler,
    RequestTypeHandler? requestTypeHandler,
    this.needHeaders = true,
    this.headers,
  }) {
    typeHandler = requestTypeHandler ?? RequestTypeHandler.jsonUTF8;
  }
}