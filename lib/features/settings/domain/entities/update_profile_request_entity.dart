import 'package:equatable/equatable.dart';

class UpdateProfileRequestEntity extends Equatable {
  const UpdateProfileRequestEntity({
    required this.fullName,
    required this.preferredLanguage,
  });

  final String fullName;
  final String preferredLanguage;

  @override
  List<Object?> get props => [fullName, preferredLanguage];
}
