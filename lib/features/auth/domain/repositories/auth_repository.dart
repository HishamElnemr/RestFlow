import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/auth_response_entity.dart';
import '../entities/login_request_entity.dart';
import '../entities/refresh_token_request_entity.dart';
import '../entities/register_request_entity.dart';
import '../entities/verify_otp_request_entity.dart';

abstract class AuthRepository {
  Future<Either<AppFailure, AuthResponseEntity>> register(
    RegisterRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> verifyOtp(
    VerifyOtpRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> login(
    LoginRequestEntity request,
  );

  Future<Either<AppFailure, AuthResponseEntity>> refreshToken(
    RefreshTokenRequestEntity request,
  );
}
