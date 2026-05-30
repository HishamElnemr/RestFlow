import '../../domain/entities/channel_type.dart';
import '../../domain/entities/verify_otp_request_entity.dart';

class VerifyOtpRequestModel extends VerifyOtpRequestEntity {
  const VerifyOtpRequestModel({
    required super.email,
    required super.code,
    required super.channel,
  });

  factory VerifyOtpRequestModel.fromEntity(VerifyOtpRequestEntity entity) {
    return VerifyOtpRequestModel(
      email: entity.email,
      code: entity.code,
      channel: entity.channel,
    );
  }

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequestModel(
      email: (json['email'] ?? '').toString(),
      code: (json['code'] ?? '').toString(),
      channel: _parseChannelType(json['channel']),
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'code': code,
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
