import 'package:flutter/material.dart';
import 'package:the_movie_db/data/models/app_model.dart';
import 'package:the_movie_db/domain/api/auth/auth_api_client.dart';
import 'package:the_movie_db/domain/api/auth/auth_exception.dart';


class AuthModel extends ChangeNotifier {

  AuthModel() {
    _listenController(loginController);
    _listenController(passwordController);
  }

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  String get errorMessage => _errorMessage;
  bool get canSendAuthRequest => _canSendAuthRequest;

  // Добавить лимит реквестов (10 + первый)
  Future<void> logIn() async {
    var login = _login;
    var password = _password;

    if (!_isValidString(login) || !_isValidString(password)) {   
      _errorMessage = 'Проверьте корректность введенных данных. Поля не должны быть пустыми';
      notifyListeners();
      return;
    }
    _errorMessage = '';
    _canSendAuthRequest = false;
    notifyListeners();

    try {      
      final sessionID = await _authAPIClient.auth(login, password);
      await AppModel.instanse.setSessionID(sessionID);
    } catch (exception) {
      if (exception is AuthException) {
        _errorMessage = exception.errorMessage;
      } else {
        _errorMessage = const AuthException(AuthExceptionType.other).errorMessage;
      }
      _canSendAuthRequest = true;
      notifyListeners();
    }     
  }

  Future<void> logOut() async {
    final sessionID = await AppModel.instanse.sessionID;
    if (sessionID == null) return;

    final success = await _authAPIClient.logout(sessionID);
    if (!success) return;
    AppModel.instanse.deleteSessionID();
    notifyListeners();
  }

  final AuthAPIClient _authAPIClient = AuthAPIClient();
  String _errorMessage = '';
  bool _canSendAuthRequest = true;
  String get _login => loginController.text.trim();
  String get _password => passwordController.text.trim();
  
  bool _isValidString(String value) {
    return value.isNotEmpty && !value.contains(' ');
  }

  void _listenController(TextEditingController controller) {

    String oldValue = '';
    bool isFirstTime = true;
    controller.addListener(() {
      if (_errorMessage.isEmpty) return;

      if (isFirstTime) {
        oldValue = controller.text;
        isFirstTime = false;
        return;
      } 

      if (oldValue == controller.text) return;

      _errorMessage = '';
      isFirstTime = true;
      notifyListeners();      
    });
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}