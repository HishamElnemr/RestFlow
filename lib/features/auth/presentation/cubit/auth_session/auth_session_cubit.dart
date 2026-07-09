import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/secure_storage_service.dart';
import '../../../../../core/utils/jwt_utils.dart';
import '../../../domain/entities/logout_request_entity.dart';
import '../../../domain/entities/refresh_token_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authRepository, this._secureStorage)
      : super(const AuthSessionInitial());

  final AuthRepository _authRepository;
  final SecureStorageService _secureStorage;

  Future<void> checkAuthStatus() async {
    emit(const AuthSessionLoading());

    final accessToken = await _secureStorage.readAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      emit(const AuthSessionUnauthenticated());
      return;
    }

    if (!JwtUtils.isExpired(accessToken)) {
      final role = JwtUtils.getRole(accessToken);
      emit(AuthSessionAuthenticated(role: role));
      return;
    }

    final refreshToken = await _secureStorage.readRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _secureStorage.deleteTokens();
      emit(const AuthSessionUnauthenticated());
      return;
    }

    final result = await _authRepository.refreshToken(
      RefreshTokenRequestEntity(refreshToken: refreshToken),
    );

    if (isClosed) return;

    result.fold(
      (_) async {
        await _secureStorage.deleteTokens();
        emit(const AuthSessionUnauthenticated());
      },
      (authResponse) async {
        final newToken = authResponse.token;
        if (newToken == null || newToken.isEmpty) {
          await _secureStorage.deleteTokens();
          emit(const AuthSessionUnauthenticated());
          return;
        }
        final role = JwtUtils.getRole(newToken);
        emit(AuthSessionAuthenticated(role: role));
      },
    );
  }

  Future<void> getMe() async {
    emit(const AuthSessionLoading());
    final result = await _authRepository.getMe();
    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (user) => emit(AuthSessionGetMeSuccess(user)),
    );
  }

  Future<void> logout(LogoutRequestEntity request) async {
    emit(const AuthSessionLoading());
    final result = await _authRepository.logout(request);
    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (_) => emit(const AuthSessionLogoutSuccess()),
    );
  }

  void reset() => emit(const AuthSessionInitial());
}
