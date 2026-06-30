import '../../domain/entities/logo_upload_response_entity.dart';

class LogoUploadResponseModel extends LogoUploadResponseEntity {
  const LogoUploadResponseModel({
    required super.logoUrl,
    required super.message,
  });

  LogoUploadResponseEntity toEntity() {
    return LogoUploadResponseEntity(logoUrl: logoUrl, message: message);
  }

  factory LogoUploadResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoUploadResponseModel(
      logoUrl: (json['logoUrl'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'logoUrl': logoUrl,
        'message': message,
      };
}
