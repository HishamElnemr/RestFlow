import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/forgot_password_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
      : super(const ForgotPasswordInitial());

  final AuthRepository _authRepository;

  /// Sends a forgot-password OTP to the user's email/phone.
  Future<void> forgotPassword(ForgotPasswordRequestEntity request) async {
    emit(const ForgotPasswordLoading());
    final result = await _authRepository.forgotPassword(request);
    result.fold(
      (failure) => emit(ForgotPasswordFailure(failure)),
      (_) => emit(const ForgotPasswordSuccess()),
    );
  }

  void reset() => emit(const ForgotPasswordInitial());
}
