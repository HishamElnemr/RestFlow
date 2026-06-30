import 'package:equatable/equatable.dart';

class MessageResponseEntity extends Equatable {
  const MessageResponseEntity({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
