import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/resend_otp_request_entity.dart';
import '../../../domain/entities/verify_otp_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._authRepository) : super(const OtpInitial());

  final AuthRepository _authRepository;

  Future<void> verifyOtp(VerifyOtpRequestEntity request) async {
    emit(const OtpLoading(OtpAction.verify));
    final result = await _authRepository.verifyOtp(request);
    result.fold(
      (failure) => emit(OtpFailure(failure, OtpAction.verify)),
      (response) => emit(OtpSuccess(response, OtpAction.verify)),
    );
  }

  Future<void> resendOtp(ResendOtpRequestEntity request) async {
    emit(const OtpLoading(OtpAction.resend));
    final result = await _authRepository.resendOtp(request);
    result.fold(
      (failure) => emit(OtpFailure(failure, OtpAction.resend)),
      (response) => emit(OtpSuccess(response, OtpAction.resend)),
    );
  }

  void reset() {
    emit(const OtpInitial());
  }
}
