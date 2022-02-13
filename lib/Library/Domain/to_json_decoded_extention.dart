import 'dart:async';
import 'dart:convert';
import 'dart:io';


abstract class ResponseStreamDecoders {
  static Future<dynamic> toJsonUTF8Decoded(HttpClientResponse response) async{
    return response.transform(utf8.decoder)
    .toList()
    .then((strList) => strList.join())
    .then((strJson) => jsonDecode(strJson));
  }
}

extension ToJsonDecoded on HttpClientResponse {

  /// By default, the utf8.decoder stream transformer is used
  Future<dynamic> toJsonDecoded()  
    => ResponseStreamDecoders.toJsonUTF8Decoded(this);
}