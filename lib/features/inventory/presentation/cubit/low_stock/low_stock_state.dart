import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../domain/entities/low_stock_alert_entity.dart';

abstract class LowStockState extends Equatable {
  const LowStockState();

  @override
  List<Object?> get props => [];
}

class LowStockInitial extends LowStockState {
  const LowStockInitial();
}

class LowStockLoading extends LowStockState {
  const LowStockLoading();
}

class LowStockSuccess extends LowStockState {
  const LowStockSuccess(this.alerts);

  final List<LowStockAlertEntity> alerts;

  @override
  List<Object?> get props => [alerts];
}

class LowStockFailure extends LowStockState {
  const LowStockFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
