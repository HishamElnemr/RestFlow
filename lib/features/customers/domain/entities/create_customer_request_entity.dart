import 'package:equatable/equatable.dart';

class CreateCustomerRequestEntity extends Equatable {
  const CreateCustomerRequestEntity({
    required this.fullName,
    required this.phoneNumber,
  });

  final String fullName;
  final String phoneNumber;

  @override
  List<Object?> get props => [fullName, phoneNumber];
}
