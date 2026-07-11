import '../../domain/entities/employee_response_entity.dart';
import 'employee_model.dart';

class EmployeeResponseModel {
  const EmployeeResponseModel({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  final bool isSuccess;
  final String message;
  final EmployeeModel? data;

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? EmployeeModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  EmployeeResponseEntity toEntity() {
    return EmployeeResponseEntity(
      isSuccess: isSuccess,
      message: message,
      data: data?.toEntity(),
    );
  }
}
