import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/login_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginInitial());

  final AuthRepository _authRepository;

  Future<void> login(LoginRequestEntity request) async {
    emit(const LoginLoading());
    final result = await _authRepository.login(request);
    result.fold(
      (failure) => emit(LoginFailure(failure)),
      (response) => emit(LoginSuccess(response)),
    );
  }

  void reset() {
    emit(const LoginInitial());
  }
}
