import '../../domain/entities/update_customer_request_entity.dart';

class UpdateCustomerRequestModel extends UpdateCustomerRequestEntity {
  const UpdateCustomerRequestModel({super.fullName, super.phoneNumber});

  factory UpdateCustomerRequestModel.fromEntity(
    UpdateCustomerRequestEntity entity,
  ) {
    return UpdateCustomerRequestModel(
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
    );
  }

  factory UpdateCustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateCustomerRequestModel(
      fullName: json['fullName']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
  };
}
