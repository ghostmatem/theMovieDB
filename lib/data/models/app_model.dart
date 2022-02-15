import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_movie_db/domain/api/auth/auth_api_client.dart';


class AppModel {

  // Добавить лимит реквестов (10 + первый)
  static AppModel get instanse => _instanse;
  Future<String?> get sessionID => _sessionStorage.readSessionID();
  bool get isLoggedIn => _isLoggedIn;
  
  Future<void> setSessionID(String sessionID) async {
    if (sessionID.trim().isEmpty) return;
    _isLoggedIn = true;
    return await _sessionStorage.saveSessionID(sessionID);
  }

  Future<void> deleteSessionID() async{
    _isLoggedIn = false;
    return await _sessionStorage.deleteSessionID();
  }

  static Future<void> initInstanse() async {
    _instanse = AppModel._();
    await _instanse.checkAuth();
    
  }

  Future<void> checkAuth() async {
    final _sessionID = await sessionID;
    if (_sessionID == null) return;

    try {
      _isLoggedIn = await AuthAPIClient.testAuth(_sessionID);
    } catch (_) { }
    
  }

  bool _isLoggedIn = false;
  final _SessionIDProvider _sessionStorage = _SessionIDProvider();
  static late final AppModel _instanse;
  AppModel._();
}

class _SessionIDProvider {

  final String _key = 'session_id';

  final storage = const FlutterSecureStorage();

  Future<void> saveSessionID(String sessionID) async {
    await storage.write(key: _key, value: sessionID);
    return;
  }

  Future<String?> readSessionID() async {
    return await storage.read(key: _key);
  }

  Future<void> deleteSessionID() async {
    return await storage.delete(key: _key);
  }
}