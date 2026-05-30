import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_status.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    super.updatedAt,
  });

  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      id: entity.id,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: (json['id'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      status: _statusFromJson((json['status'] ?? '').toString()),
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'status': _statusToJson(status),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}

CustomerStatus _statusFromJson(String value) {
  switch (value) {
    case 'Active':
      return CustomerStatus.active;
    case 'Inactive':
      return CustomerStatus.inactive;
    default:
      return CustomerStatus.active;
  }
}

String _statusToJson(CustomerStatus status) {
  switch (status) {
    case CustomerStatus.active:
      return 'Active';
    case CustomerStatus.inactive:
      return 'Inactive';
  }
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  final text = value.toString();
  if (text.isEmpty) {
    return null;
  }
  return DateTime.parse(text);
}
