import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/auth_response_model.dart';
import '../../features/auth/data/models/login_request_model.dart';
import '../../features/auth/data/models/refresh_token_request_model.dart';
import '../../features/auth/data/models/register_request_model.dart';
import '../../features/auth/data/models/resend_otp_request_model.dart';
import '../../features/auth/data/models/verify_otp_request_model.dart';
import '../../features/auth/data/models/forgot_password_request_model.dart';
import '../../features/auth/data/models/reset_password_request_model.dart';
import '../../features/auth/data/models/logout_request_model.dart';
import '../../features/auth/data/models/change_password_request_model.dart';
import '../../features/auth/data/models/user_profile_result_model.dart';
import '../constants/api_constants.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/api/Auth/register')
  Future<AuthResponseModel> register(@Body() RegisterRequestModel request);

  @POST('/api/Auth/verify-otp')
  Future<AuthResponseModel> verifyOtp(@Body() VerifyOtpRequestModel request);

  @POST('/api/Auth/resend-otp')
  Future<AuthResponseModel> resendOtp(@Body() ResendOtpRequestModel request);

  @POST('/api/Auth/login')
  Future<AuthResponseModel> login(@Body() LoginRequestModel request);

  @POST('/api/Auth/refresh-token')
  Future<AuthResponseModel> refreshToken(
    @Body() RefreshTokenRequestModel request,
  );

  @POST('/api/Auth/forgot-password')
  Future<AuthResponseModel> forgotPassword(
    @Body() ForgotPasswordRequestModel request,
  );

  @POST('/api/Auth/reset-password')
  Future<AuthResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );

  @POST('/api/Auth/logout')
  Future<AuthResponseModel> logout(
    @Body() LogoutRequestModel request,
  );

  @GET('/api/Auth/me')
  Future<UserProfileResultModel> getMe();

  @POST('/api/Auth/change-password')
  Future<AuthResponseModel> changePassword(
    @Body() ChangePasswordRequestModel request,
  );
}

