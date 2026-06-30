import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/update_restaurant_settings_request_entity.dart';
import '../../../domain/repositories/settings_repository.dart';
import 'restaurant_settings_state.dart';

class RestaurantSettingsCubit extends Cubit<RestaurantSettingsState> {
  RestaurantSettingsCubit(this._settingsRepository)
      : super(const RestaurantSettingsInitial());

  final SettingsRepository _settingsRepository;

  /// Fetches the restaurant's current settings (name, logo, cuisine, etc.).
  Future<void> fetchRestaurantSettings() async {
    emit(const RestaurantSettingsLoading(RestaurantSettingsAction.fetch));
    final result = await _settingsRepository.fetchRestaurantSettings();
    result.fold(
      (failure) => emit(
        RestaurantSettingsFailure(failure, RestaurantSettingsAction.fetch),
      ),
      (settings) => emit(RestaurantSettingsLoaded(settings)),
    );
  }

  /// Partially updates the restaurant settings.
  Future<void> updateRestaurantSettings(
    UpdateRestaurantSettingsRequestEntity request,
  ) async {
    emit(const RestaurantSettingsLoading(RestaurantSettingsAction.update));
    final result = await _settingsRepository.updateRestaurantSettings(request);
    result.fold(
      (failure) => emit(
        RestaurantSettingsFailure(failure, RestaurantSettingsAction.update),
      ),
      (_) => emit(const RestaurantSettingsUpdateSuccess()),
    );
  }

  /// Uploads a new restaurant logo and emits the logo URL response.
  Future<void> uploadRestaurantLogo(MultipartFile file) async {
    emit(const RestaurantSettingsLoading(RestaurantSettingsAction.uploadLogo));
    final result = await _settingsRepository.uploadRestaurantLogo(file);
    result.fold(
      (failure) => emit(
        RestaurantSettingsFailure(
          failure,
          RestaurantSettingsAction.uploadLogo,
        ),
      ),
      (response) => emit(RestaurantSettingsLogoUploadSuccess(response)),
    );
  }

  void reset() => emit(const RestaurantSettingsInitial());
}
