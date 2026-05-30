import '../../domain/entities/channel_type.dart';
import '../../domain/entities/resend_otp_request_entity.dart';

class ResendOtpRequestModel extends ResendOtpRequestEntity {
  const ResendOtpRequestModel({required super.email, required super.channel});

  factory ResendOtpRequestModel.fromEntity(ResendOtpRequestEntity entity) {
    return ResendOtpRequestModel(email: entity.email, channel: entity.channel);
  }

  factory ResendOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpRequestModel(
      email: (json['email'] ?? '').toString(),
      channel: _parseChannelType(json['channel']),
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'channel': _channelTypeToJson(channel),
  };
}

ChannelType _parseChannelType(dynamic value) {
  final normalized = value?.toString().toLowerCase();
  if (normalized == 'email') {
    return ChannelType.email;
  }
  if (normalized == 'phone') {
    return ChannelType.phone;
  }
  throw FormatException('Invalid channel type: $value');
}

String _channelTypeToJson(ChannelType value) {
  switch (value) {
    case ChannelType.email:
      return 'Email';
    case ChannelType.phone:
      return 'Phone';
  }
}
