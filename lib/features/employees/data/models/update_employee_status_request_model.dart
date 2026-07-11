import '../../domain/entities/employee_status.dart';
import '../../domain/entities/update_employee_status_request_entity.dart';

class UpdateEmployeeStatusRequestModel {
  const UpdateEmployeeStatusRequestModel({required this.status});

  final int status;

  factory UpdateEmployeeStatusRequestModel.fromEntity(
      UpdateEmployeeStatusRequestEntity entity) {
    return UpdateEmployeeStatusRequestModel(
      status: _mapStatusToInt(entity.status),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }

  static int _mapStatusToInt(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return 0;
      case EmployeeStatus.inactive:
        return 1;
    }
  }
}
