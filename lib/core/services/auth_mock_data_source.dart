import '../errors/auth_exceptions.dart';
import '../../features/auth/domain/entities/channel_type.dart';
import '../../features/auth/data/models/auth_response_model.dart';
import '../../features/auth/data/models/login_request_model.dart';
import '../../features/auth/data/models/refresh_token_request_model.dart';
import '../../features/auth/data/models/register_request_model.dart';
import '../../features/auth/data/models/verify_otp_request_model.dart';

class AuthMockDataSource {
  static const Duration _latency = Duration(seconds: 2);
  static const String _defaultOtp = '123456';

  final Map<String, _MockUser> _usersByEmail = {};
  final Map<String, _MockUser> _usersByPhone = {};

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    await Future.delayed(_latency);

    if (request.password != request.confirmPassword) {
      throw const PasswordMismatchException();
    }

    final emailKey = request.email.trim().toLowerCase();
    if (_usersByEmail.containsKey(emailKey)) {
      throw const DuplicateEmailException();
    }

    final phoneKey = request.phoneNumber.trim();
    if (_usersByPhone.containsKey(phoneKey)) {
      throw const DuplicatePhoneException();
    }

    final user = _MockUser(
      fullName: request.fullName.trim(),
      email: request.email.trim(),
      phoneNumber: phoneKey,
      password: request.password,
    );

    _usersByEmail[emailKey] = user;
    _usersByPhone[phoneKey] = user;

    return const AuthResponseModel(
      isSuccess: true,
      message: 'Registration successful. Please verify your email and phone.',
    );
  }

  Future<AuthResponseModel> verifyOtp(VerifyOtpRequestModel request) async {
    await Future.delayed(_latency);

    final emailKey = request.email.trim().toLowerCase();
    final user = _usersByEmail[emailKey];
    if (user == null) {
      throw const UserNotFoundException();
    }

    if (request.code.trim() != _defaultOtp) {
      throw const InvalidOtpException();
    }

    if (request.channel == ChannelType.email) {
      user.emailVerified = true;
    } else {
      user.phoneVerified = true;
    }

    var message = request.channel == ChannelType.email
        ? 'Email verified.'
        : 'Phone verified.';
    if (user.isActive) {
      message = '$message Account is now active.';
    }

    return AuthResponseModel(isSuccess: true, message: message);
  }

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    await Future.delayed(_latency);

    final user = _findUserByIdentifier(request.email);
    if (user == null) {
      throw const InvalidCredentialsException();
    }

    if (user.password != request.password) {
      throw const InvalidCredentialsException();
    }

    if (!user.isActive) {
      throw const AccountInactiveException();
    }

    final accessToken = _buildMockToken('access', user.email);
    final refreshToken = _buildMockToken('refresh', user.email);
    user.refreshToken = refreshToken;

    return AuthResponseModel(
      isSuccess: true,
      message: 'Login successful.',
      token: accessToken,
      refreshToken: refreshToken,
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 15)),
    );
  }

  Future<AuthResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  ) async {
    await Future.delayed(_latency);

    final user = _findUserByRefreshToken(request.refreshToken);
    if (user == null) {
      throw const InvalidRefreshTokenException();
    }

    final accessToken = _buildMockToken('access', user.email);
    final refreshToken = _buildMockToken('refresh', user.email);
    user.refreshToken = refreshToken;

    return AuthResponseModel(
      isSuccess: true,
      message: 'Session refreshed successfully.',
      token: accessToken,
      refreshToken: refreshToken,
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 15)),
    );
  }

  _MockUser? _findUserByIdentifier(String identifier) {
    final emailKey = identifier.trim().toLowerCase();
    final byEmail = _usersByEmail[emailKey];
    if (byEmail != null) {
      return byEmail;
    }
    final phoneKey = identifier.trim();
    return _usersByPhone[phoneKey];
  }

  _MockUser? _findUserByRefreshToken(String refreshToken) {
    for (final user in _usersByEmail.values) {
      if (user.refreshToken == refreshToken) {
        return user;
      }
    }
    return null;
  }

  String _buildMockToken(String prefix, String email) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'mock_${prefix}_${email}_$timestamp';
  }
}

class _MockUser {
  _MockUser({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  bool emailVerified = false;
  bool phoneVerified = false;
  String? refreshToken;

  bool get isActive => emailVerified && phoneVerified;
}
