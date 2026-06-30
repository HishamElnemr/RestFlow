import 'package:equatable/equatable.dart';

class ChangePasswordRequestEntity extends Equatable {
  const ChangePasswordRequestEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmNewPassword];
}
