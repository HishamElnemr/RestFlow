import 'package:equatable/equatable.dart';

class CreateEmployeeRequestEntity extends Equatable {
  const CreateEmployeeRequestEntity({
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

  @override
  List<Object?> get props => [fullName, email, phoneNumber, role, password];
}
