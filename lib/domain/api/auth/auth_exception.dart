class AuthException implements Exception {

  const AuthException(this.type);

  final AuthExceptionType type;

  String get errorMessage => _messageMap[type]!;

  static const _messageMap = <AuthExceptionType, String>{
    AuthExceptionType.invalidAuthData  : 'Проверьте правильность ввода логина и пароля',
    AuthExceptionType.emailNotVerified : 'Ваш email не подтвержден',
    AuthExceptionType.network          : 'Проверьте ваше подключение к интернету или попробуйте повторить попытку позже',
    AuthExceptionType.server           : 'Не удалось установить соединение с ресурсом',
    AuthExceptionType.resourseNotFound : 'Ресурс, к которому вы обратились не найден',
    AuthExceptionType.other            : 'Похоже произошла неизвестная ошибка. Попробуйте повторить попытку позже',
  }; 

}

enum AuthExceptionType {
  invalidAuthData,
  emailNotVerified,
  network,
  server,
  other,
  resourseNotFound,
}