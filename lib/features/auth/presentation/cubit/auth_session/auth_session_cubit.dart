import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/logout_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authRepository) : super(const AuthSessionInitial());

  final AuthRepository _authRepository;

  /// Fetches the currently authenticated user's profile from the server.
  Future<void> getMe() async {
    emit(const AuthSessionLoading());
    final result = await _authRepository.getMe();
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (user) => emit(AuthSessionGetMeSuccess(user)),
    );
  }

  /// Invalidates the session on the server and clears local tokens.
  Future<void> logout(LogoutRequestEntity request) async {
    emit(const AuthSessionLoading());
    final result = await _authRepository.logout(request);
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (_) => emit(const AuthSessionLogoutSuccess()),
    );
  }

  void reset() => emit(const AuthSessionInitial());
}
