import '../../domain/entities/status_distribution_entity.dart';

class StatusDistributionModel extends StatusDistributionEntity {
  const StatusDistributionModel({
    required super.pending,
    required super.completed,
    required super.cancelled,
  });

  factory StatusDistributionModel.fromJson(Map<String, dynamic> json) {
    return StatusDistributionModel(
      pending: json['pending'] as int? ?? 0,
      completed: json['completed'] as int? ?? 0,
      cancelled: json['cancelled'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
      'completed': completed,
      'cancelled': cancelled,
    };
  }

  StatusDistributionEntity toEntity() {
    return StatusDistributionEntity(
      pending: pending,
      completed: completed,
      cancelled: cancelled,
    );
  }
}
