import 'package:equatable/equatable.dart';

class StatusDistributionEntity extends Equatable {
  const StatusDistributionEntity({
    required this.pending,
    required this.completed,
    required this.cancelled,
  });

  final int pending;
  final int completed;
  final int cancelled;

  @override
  List<Object?> get props => [pending, completed, cancelled];
}
