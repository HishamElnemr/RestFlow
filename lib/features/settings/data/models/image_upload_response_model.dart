import '../../domain/entities/image_upload_response_entity.dart';

class ImageUploadResponseModel extends ImageUploadResponseEntity {
  const ImageUploadResponseModel({
    required super.imageUrl,
    required super.message,
  });

  ImageUploadResponseEntity toEntity() {
    return ImageUploadResponseEntity(imageUrl: imageUrl, message: message);
  }

  factory ImageUploadResponseModel.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponseModel(
      imageUrl: (json['imageUrl'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'message': message,
      };
}
