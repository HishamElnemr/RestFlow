import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/reset_password_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authRepository)
      : super(const ResetPasswordInitial());

  final AuthRepository _authRepository;

  /// Validates the OTP and sets the new password.
  Future<void> resetPassword(ResetPasswordRequestEntity request) async {
    emit(const ResetPasswordLoading());
    final result = await _authRepository.resetPassword(request);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }

  void reset() => emit(const ResetPasswordInitial());
}
