import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/change_password_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authRepository)
      : super(const ChangePasswordInitial());

  final AuthRepository _authRepository;

  /// Changes the authenticated user's password.
  Future<void> changePassword(ChangePasswordRequestEntity request) async {
    emit(const ChangePasswordLoading());
    final result = await _authRepository.changePassword(request);
    result.fold(
      (failure) => emit(ChangePasswordFailure(failure)),
      (_) => emit(const ChangePasswordSuccess()),
    );
  }

  void reset() => emit(const ChangePasswordInitial());
}
