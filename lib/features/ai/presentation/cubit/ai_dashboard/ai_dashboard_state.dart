import 'package:equatable/equatable.dart';

import 'package:rest_flow/core/errors/app_failure.dart';
import 'package:rest_flow/features/ai/domain/entities/dashboard_insight_entity.dart';

abstract class AiDashboardState extends Equatable {
  const AiDashboardState();

  @override
  List<Object?> get props => [];
}

class AiDashboardInitial extends AiDashboardState {
  const AiDashboardInitial();
}

class AiDashboardLoading extends AiDashboardState {
  const AiDashboardLoading();
}

class AiDashboardSuccess extends AiDashboardState {
  final List<DashboardInsightEntity> insights;

  const AiDashboardSuccess(this.insights);

  @override
  List<Object?> get props => [insights];
}

class AiDashboardError extends AiDashboardState {
  final AppFailure failure;

  const AiDashboardError(this.failure);

  @override
  List<Object?> get props => [failure];
}
