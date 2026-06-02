import 'package:equatable/equatable.dart';

import '../../../../../core/errors/app_failure.dart';

abstract class LowStockCountState extends Equatable {
  const LowStockCountState();

  @override
  List<Object?> get props => [];
}

class LowStockCountInitial extends LowStockCountState {
  const LowStockCountInitial();
}

class LowStockCountLoading extends LowStockCountState {
  const LowStockCountLoading();
}

class LowStockCountSuccess extends LowStockCountState {
  const LowStockCountSuccess(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

class LowStockCountFailure extends LowStockCountState {
  const LowStockCountFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
