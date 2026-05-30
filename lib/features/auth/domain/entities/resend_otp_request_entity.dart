import 'package:equatable/equatable.dart';

import 'channel_type.dart';

class ResendOtpRequestEntity extends Equatable {
  const ResendOtpRequestEntity({required this.email, required this.channel});

  final String email;
  final ChannelType channel;

  @override
  List<Object?> get props => [email, channel];
}
