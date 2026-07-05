import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  const UserProfileEntity({
    required this.fullName,
    this.profileImageUrl,
    required this.preferredLanguage,
    required this.email,
    required this.phoneNumber,
  });

  final String fullName;
  final String? profileImageUrl;
  final String preferredLanguage;
  final String email;
  final String phoneNumber;

  @override
  List<Object?> get props => [
        fullName,
        profileImageUrl,
        preferredLanguage,
        email,
        phoneNumber,
      ];
}
