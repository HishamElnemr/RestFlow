import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/auth_response_model.dart';
import '../../features/auth/data/models/login_request_model.dart';
import '../../features/auth/data/models/refresh_token_request_model.dart';
import '../../features/auth/data/models/register_request_model.dart';
import '../../features/auth/data/models/resend_otp_request_model.dart';
import '../../features/auth/data/models/verify_otp_request_model.dart';
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
}
