import '../../domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.isSuccess,
    super.message,
    super.token,
    super.refreshToken,
    super.expiresAt,
    super.errors,
  });

  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      isSuccess: isSuccess,
      message: message,
      token: token,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      errors: errors,
    );
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      isSuccess: json['isSuccess'] == true,
      message: json['message']?.toString(),
      token: json['token']?.toString(),
      refreshToken: json['refreshToken']?.toString(),
      expiresAt: _parseDateTime(json['expiresAt']),
      errors: _parseErrors(json['errors']),
    );
  }

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'message': message,
    'token': token,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt?.toIso8601String(),
    'errors': errors,
  };
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  final text = value.toString();
  if (text.isEmpty) {
    return null;
  }
  return DateTime.parse(text);
}

List<String>? _parseErrors(dynamic value) {
  if (value is List) {
    return value.map((item) => item.toString()).toList();
  }
  return null;
}
