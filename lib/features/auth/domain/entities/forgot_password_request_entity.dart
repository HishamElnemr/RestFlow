import 'package:equatable/equatable.dart';

class ForgotPasswordRequestEntity extends Equatable {
  const ForgotPasswordRequestEntity({required this.identifier});

  final String identifier;

  @override
  List<Object?> get props => [identifier];
}
