import 'package:equatable/equatable.dart';

import 'channel_type.dart';

class VerifyOtpRequestEntity extends Equatable {
  const VerifyOtpRequestEntity({
    required this.email,
    required this.code,
    required this.channel,
  });

  final String email;
  final String code;
  final ChannelType channel;

  @override
  List<Object?> get props => [email, code, channel];
}
