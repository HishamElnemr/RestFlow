import '../../domain/entities/create_customer_request_entity.dart';

class CreateCustomerRequestModel extends CreateCustomerRequestEntity {
  const CreateCustomerRequestModel({
    required super.fullName,
    required super.phoneNumber,
  });

  factory CreateCustomerRequestModel.fromEntity(
    CreateCustomerRequestEntity entity,
  ) {
    return CreateCustomerRequestModel(
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
    );
  }

  factory CreateCustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateCustomerRequestModel(
      fullName: (json['fullName'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
  };
}
