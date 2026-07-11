import '../../domain/entities/create_employee_request_entity.dart';

class CreateEmployeeRequestModel {
  const CreateEmployeeRequestModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String password;

  factory CreateEmployeeRequestModel.fromEntity(
      CreateEmployeeRequestEntity entity) {
    return CreateEmployeeRequestModel(
      fullName: entity.fullName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'password': password,
    };
  }
}
