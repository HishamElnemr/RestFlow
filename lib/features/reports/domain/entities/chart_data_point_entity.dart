import 'package:equatable/equatable.dart';

class ChartDataPointEntity extends Equatable {
  const ChartDataPointEntity({
    required this.label,
    required this.amount,
  });

  final String label;
  final double amount;

  @override
  List<Object?> get props => [label, amount];
}
