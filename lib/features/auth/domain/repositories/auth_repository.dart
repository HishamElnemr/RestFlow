import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_failure.dart';
import '../entities/auth_response_entity.dart';
import '../entities/login_request_entity.dart';
import '../entities/refresh_token_request_entity.dart';
import '../entities/register_request_entity.dart';
import '../entities/resend_otp_request_entity.dart';
import '../entities/verify_otp_request_entity.dart';
import '../entities/forgot_password_request_entity.dart';
import '../entities/reset_password_request_entity.dart';
import '../entities/logout_request_entity.dart';
import '../entities/change_password_request_entity.dart';
import '../entities/user_profile_result_entity.dart';

abstract class AuthRepository {
  Future<Either<AppFailure, AuthResponseEntity>> register(
    RegisterRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> verifyOtp(
    VerifyOtpRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> resendOtp(
    ResendOtpRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> login(
    LoginRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> refreshToken(
    RefreshTokenRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> forgotPassword(
    ForgotPasswordRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> logout(
    LogoutRequestEntity request,
  );

  Future<Either<AppFailure, UserProfileResultEntity>> getMe();

  Future<Either<AppFailure, AuthResponseEntity>> changePassword(
    ChangePasswordRequestEntity request,
  );
}

