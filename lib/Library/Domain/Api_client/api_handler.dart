import 'dart:convert';
import 'dart:io';

import '../to_json_decoded_extention.dart';

class RequestTypeHandler {
  static final RequestTypeHandler jsonUTF8 = RequestTypeHandler(
    contentType: ContentType.json,
    requestBodyEncoder: (requestBody) =>
      jsonEncode(requestBody)
  );

  final ContentType contentType;
  final dynamic Function (dynamic content) requestBodyEncoder;

  RequestTypeHandler(
    {
      required this.contentType, 
      required this.requestBodyEncoder, 
  });
}

class ResponseHandler<T> {
  final T Function(dynamic json) contentParser;
  final Future<dynamic> Function (HttpClientResponse response) streamDecoder;
  final void Function(HttpClientResponse response, dynamic json)? validator;

  ResponseHandler({
    required this.contentParser,
    this.validator,
    this.streamDecoder = ResponseStreamDecoders.toJsonUTF8Decoded
  });

}