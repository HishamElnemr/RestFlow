import 'package:equatable/equatable.dart';

class LogoUploadResponseEntity extends Equatable {
  const LogoUploadResponseEntity({
    required this.logoUrl,
    required this.message,
  });

  final String logoUrl;
  final String message;

  @override
  List<Object?> get props => [logoUrl, message];
}
