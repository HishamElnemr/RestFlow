import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/secure_storage_service.dart';
import '../../../domain/entities/logout_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authRepository, this._secureStorage)
      : super(const AuthSessionInitial());

  final AuthRepository _authRepository;
  final SecureStorageService _secureStorage;

  /// Checks local token to decide if user is already authenticated.
  Future<void> checkAuthStatus() async {
    emit(const AuthSessionLoading());
    final token = await _secureStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      emit(const AuthSessionAuthenticated());
    } else {
      emit(const AuthSessionUnauthenticated());
    }
  }

  /// Fetches the currently authenticated user's profile from the server.
  Future<void> getMe() async {
    emit(const AuthSessionLoading());
    final result = await _authRepository.getMe();
    if (isClosed) return;
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (user) => emit(AuthSessionGetMeSuccess(user)),
    );
  }

  /// Invalidates the session on the server and clears local tokens.
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
