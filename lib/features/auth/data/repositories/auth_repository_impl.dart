import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/services/auth_api_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/refresh_token_request_entity.dart';
import '../../domain/entities/register_request_entity.dart';
import '../../domain/entities/verify_otp_request_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request_model.dart';
import '../models/refresh_token_request_model.dart';
import '../models/register_request_model.dart';
import '../models/verify_otp_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    AuthApiService? apiService,
    SecureStorageService? secureStorage,
  }) : _apiService = apiService ?? AuthApiService(Dio()),
      _secureStorage = secureStorage ?? SecureStorageService();

  final AuthApiService _apiService;
  final SecureStorageService _secureStorage;

  @override
  Future<Either<AppFailure, AuthResponseEntity>> register(
    RegisterRequestEntity request,
  ) async {
    try {
      final response = await _apiService.register(
        RegisterRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, AuthResponseEntity>> verifyOtp(
    VerifyOtpRequestEntity request,
  ) async {
    try {
      final response = await _apiService.verifyOtp(
        VerifyOtpRequestModel.fromEntity(request),
      );
      return Right(response.toEntity());
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, AuthResponseEntity>> login(
    LoginRequestEntity request,
  ) async {
    try {
      final response = await _apiService.login(
        LoginRequestModel.fromEntity(request),
      );
      final entity = response.toEntity();
      await _saveTokens(entity);
      return Right(entity);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppFailure, AuthResponseEntity>> refreshToken(
    RefreshTokenRequestEntity request,
  ) async {
    try {
      final response = await _apiService.refreshToken(
        RefreshTokenRequestModel.fromEntity(request),
      );
      final entity = response.toEntity();
      await _saveTokens(entity);
      return Right(entity);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  Future<void> _saveTokens(AuthResponseEntity response) async {
    final accessToken = response.token;
    final refreshToken = response.refreshToken;

    if (accessToken != null && accessToken.isNotEmpty) {
      await _secureStorage.saveAccessToken(accessToken);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _secureStorage.saveRefreshToken(refreshToken);
    }
  }
}
