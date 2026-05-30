import 'package:equatable/equatable.dart';

class UpdateCustomerRequestEntity extends Equatable {
  const UpdateCustomerRequestEntity({this.fullName, this.phoneNumber});

  final String? fullName;
  final String? phoneNumber;

  @override
  List<Object?> get props => [fullName, phoneNumber];
}
