import '../../domain/entities/customer_status.dart';
import '../../domain/entities/update_customer_status_request_entity.dart';

class UpdateCustomerStatusRequestModel
    extends UpdateCustomerStatusRequestEntity {
  const UpdateCustomerStatusRequestModel({required super.status});

  factory UpdateCustomerStatusRequestModel.fromEntity(
    UpdateCustomerStatusRequestEntity entity,
  ) {
    return UpdateCustomerStatusRequestModel(status: entity.status);
  }

  factory UpdateCustomerStatusRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateCustomerStatusRequestModel(
      status: _statusFromJson((json['status'] ?? '').toString()),
    );
  }

  Map<String, dynamic> toJson() => {'status': _statusToJson(status)};
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
