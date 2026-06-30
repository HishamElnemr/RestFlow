import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/update_profile_request_entity.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'user_profile_settings_state.dart';

class UserProfileSettingsCubit extends Cubit<UserProfileSettingsState> {
  UserProfileSettingsCubit(this._settingsRepository)
      : super(const UserProfileSettingsInitial());

  final SettingsRepository _settingsRepository;

  /// Fetches the current user's profile details.
  Future<void> fetchUserProfile() async {
    emit(const UserProfileSettingsLoading(UserProfileSettingsAction.fetch));
    final result = await _settingsRepository.fetchUserProfile();
    result.fold(
      (failure) => emit(
        UserProfileSettingsFailure(failure, UserProfileSettingsAction.fetch),
      ),
      (profile) => emit(UserProfileSettingsLoaded(profile)),
    );
  }

  /// Partially updates the user profile (fullName and/or preferredLanguage).
  Future<void> updateUserProfile(UpdateProfileRequestEntity request) async {
    emit(const UserProfileSettingsLoading(UserProfileSettingsAction.update));
    final result = await _settingsRepository.updateUserProfile(request);
    result.fold(
      (failure) => emit(
        UserProfileSettingsFailure(failure, UserProfileSettingsAction.update),
      ),
      (_) => emit(const UserProfileSettingsUpdateSuccess()),
    );
  }

  /// Uploads a new profile image and emits the image URL response.
  Future<void> uploadProfileImage(MultipartFile file) async {
    emit(
      const UserProfileSettingsLoading(UserProfileSettingsAction.uploadImage),
    );
    final result = await _settingsRepository.uploadProfileImage(file);
    result.fold(
      (failure) => emit(
        UserProfileSettingsFailure(
          failure,
          UserProfileSettingsAction.uploadImage,
        ),
      ),
      (response) => emit(UserProfileSettingsImageUploadSuccess(response)),
    );
  }

  void reset() => emit(const UserProfileSettingsInitial());
}
