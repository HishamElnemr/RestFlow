import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/ai/domain/repositories/ai_repository.dart';

import 'ai_dashboard_state.dart';

class AiDashboardCubit extends Cubit<AiDashboardState> {
  final AiRepository _repository;

  AiDashboardCubit(this._repository) : super(const AiDashboardInitial());

  Future<void> fetchInsights() async {
    emit(const AiDashboardLoading());

    final result = await _repository.getDashboardInsights();

    result.fold(
      (failure) => emit(AiDashboardError(failure)),
      (insights) => emit(AiDashboardSuccess(insights)),
    );
  }
}
