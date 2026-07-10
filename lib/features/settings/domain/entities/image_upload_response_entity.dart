import 'package:equatable/equatable.dart';

class ImageUploadResponseEntity extends Equatable {
  const ImageUploadResponseEntity({
    required this.imageUrl,
    required this.message,
  });

  final String imageUrl;
  final String message;

  @override
  List<Object?> get props => [imageUrl, message];
}
