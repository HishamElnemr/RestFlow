import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/register_request_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(const RegisterInitial());

  final AuthRepository _authRepository;

  Future<void> register(RegisterRequestEntity request) async {
    emit(const RegisterLoading());
    final result = await _authRepository.register(request);
    result.fold(
      (failure) => emit(RegisterFailure(failure)),
      (response) => emit(RegisterSuccess(response)),
    );
  }

  void reset() {
    emit(const RegisterInitial());
  }
}
