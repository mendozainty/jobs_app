// login exceptions

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exceptions
class GenericAuthException implements Exception {}

// use not login
class UserNotLoggedInAuthException implements Exception {}

// login with social media credentials
class AccountExistsDifferentCredentialAuthException implements Exception {}

class InvalidCredentialAuthException implements Exception {}
