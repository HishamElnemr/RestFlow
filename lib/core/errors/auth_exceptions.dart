abstract class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class DuplicateEmailException extends AuthException {
  const DuplicateEmailException() : super('Email is already in use.');
}

class DuplicatePhoneException extends AuthException {
  const DuplicatePhoneException() : super('Phone number is already in use.');
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Invalid credentials.');
}

class AccountInactiveException extends AuthException {
  const AccountInactiveException()
    : super('Account is not active. Please verify your email and phone.');
}

class InvalidOtpException extends AuthException {
  const InvalidOtpException() : super('Invalid OTP code.');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('User not found.');
}

class InvalidRefreshTokenException extends AuthException {
  const InvalidRefreshTokenException()
    : super('Invalid or expired refresh token.');
}

class PasswordMismatchException extends AuthException {
  const PasswordMismatchException() : super('Passwords do not match.');
}
