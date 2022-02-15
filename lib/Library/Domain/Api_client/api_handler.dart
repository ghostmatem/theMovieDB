import 'dart:convert';
import 'dart:io';

import '../to_json_decoded_extention.dart';

class RequestEncoder {
  static final RequestEncoder jsonUTF8 = RequestEncoder(
    contentType: ContentType.json,
    requestBodyEncoder: (requestBody) =>
      jsonEncode(requestBody)
  );

  final ContentType contentType;
  final dynamic Function (dynamic content) requestBodyEncoder;

  RequestEncoder(
    {
      required this.contentType, 
      required this.requestBodyEncoder, 
  });
}

class ResponseHandler<T> {
  final T Function(dynamic content) contentParser;
  final Future<dynamic> Function (HttpClientResponse response) streamDecoder;
  final void Function(HttpClientResponse response, dynamic decodedResponseBody)? validator;

  ResponseHandler({
    required this.contentParser,
    this.validator,
    this.streamDecoder = ResponseStreamDecoders.toJsonUTF8Decoded
  });

}