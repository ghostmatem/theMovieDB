import 'dart:io';

import 'package:the_movie_db/Library/Domain/Api_client/api_handler.dart';
import 'package:the_movie_db/Library/Domain/Api_client/base_api_client.dart';
import 'package:the_movie_db/Library/Domain/Api_client/http_method.dart';
import 'package:the_movie_db/Library/Domain/Api_client/request_api_arguments.dart';
import '../api_key.dart' as key;
import '../api_links.dart';
import 'auth_exception.dart';

class AuthAPIClient {

  static Future<bool> testAuth(String sessionID) async {
    try {
      final _testAPIClient = BaseAPIClient();
      return await _testAPIClient.sendRequest(
        httpMethod: HttpMethod.get,
        args: RequestAPIArguments(
          url: _testAPIClient.makeUri(
            'https://api.themoviedb.org/3', 
            '/account',
            {
              'api_key' : key.apiKey,
              'session_id' : sessionID
            }), 
          responseHandler: ResponseHandler(
            contentParser: (content) => content['status_code'] == null,
            validator: _authResponseValidator
          ))
      );
    } on SocketException {
      throw const AuthException(AuthExceptionType.network);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException(AuthExceptionType.other);
    }
  }

  Future<String> auth(String login, String password) async {
    try {
      final notAuthToken = await _getNewRequestToken();
      final validToken = await _validateUser(
      login: login,
      password: password,
      requestToken: notAuthToken
      );
      final sessionID = await _getSessionID(validToken);
      return sessionID;
    } on SocketException {
      throw const AuthException(AuthExceptionType.network);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException(AuthExceptionType.other);
    }
  }

  Future<bool> logout(String sessionID) async {
    try {
      return await _apiClient.sendRequest(
      httpMethod: HttpMethod.delete,
      requestBody: {'session_id' : sessionID},
      args: RequestAPIArguments(
        url: _apiClient.makeUri(APILinks.mainHost, _logoutPath, {'api_key': _apiKey}), 
        responseHandler: ResponseHandler(
          contentParser: (json) => json['success'] as bool,
          validator: _authResponseValidator),
      )
    );
    } on SocketException {
      throw const AuthException(AuthExceptionType.network);
    } on AuthException {
      rethrow;
    } catch (_) {
      throw const AuthException(AuthExceptionType.other);
    }
  }
  
  Future<String> _getNewRequestToken() async {
    return await _apiClient.sendRequest(
      httpMethod: HttpMethod.get,
      args: RequestAPIArguments(
        needHeaders: false,
        url: _apiClient.makeUri(APILinks.mainHost, _tokenPath, {'api_key':_apiKey}), 
        responseHandler: ResponseHandler(
          contentParser: (json) => json['request_token'],
          validator: _authResponseValidator),
      )
    );
  }

  Future<String> _validateUser({
    required String login, 
    required String password, 
    required String requestToken}) async {

    return await _authPost(
      requestBody:  {
        'username' : login,
        'password' : password,
        'request_token' : requestToken
      },
      path: _validateLoginPath,
      keyForResponseParsing: 'request_token'
    );
  }

  Future<String> _getSessionID(String validToken) async {
    return await _authPost(
      requestBody:  {'request_token' : validToken},
      path: _createSessionPath,
      keyForResponseParsing: 'session_id'
    );
  }

  Future<String> _authPost({
    required Map<String, dynamic> requestBody,
    required String path,
    required String keyForResponseParsing}) async {

      return await _apiClient.sendRequest(
        httpMethod: HttpMethod.post,
        requestBody: requestBody,
        args: RequestAPIArguments(
          url: _apiClient.makeUri(APILinks.mainHost, path, {'api_key': _apiKey}), 
          responseHandler: ResponseHandler(
            contentParser: (json) => json[keyForResponseParsing],
            validator: _authResponseValidator),
      )
    );
  }

  static void _authResponseValidator(response, json) {
    if (response.statusCode == 200) return;

    switch(json['status_code'] as int) {
      case 30: 
        throw const AuthException(AuthExceptionType.invalidAuthData);
      case 32:
        throw const AuthException(AuthExceptionType.emailNotVerified);
      case 34:
        throw const AuthException(AuthExceptionType.other);
    }
    if (response.statusCode == 401) throw const AuthException(AuthExceptionType.server);
    throw const AuthException(AuthExceptionType.resourseNotFound);
  }
 
  final String _tokenPath = '/authentication/token/new';
  final String _validateLoginPath = '/authentication/token/validate_with_login';
  final String _createSessionPath = '/authentication/session/new';
  final String _logoutPath = '/authentication/session';

  late final String _apiKey = key.apiKey;
  final BaseAPIClient _apiClient = BaseAPIClient();
}