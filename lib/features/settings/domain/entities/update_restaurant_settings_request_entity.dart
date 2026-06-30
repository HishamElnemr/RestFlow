import 'package:equatable/equatable.dart';

class UpdateRestaurantSettingsRequestEntity extends Equatable {
  const UpdateRestaurantSettingsRequestEntity({
    this.restaurantName,
    this.cuisineType,
    this.country,
    this.defaultLanguage,
    this.timezone,
    this.currency,
  });

  final String? restaurantName;
  final String? cuisineType;
  final String? country;
  final String? defaultLanguage;
  final String? timezone;
  final String? currency;

  @override
  List<Object?> get props => [
        restaurantName,
        cuisineType,
        country,
        defaultLanguage,
        timezone,
        currency,
      ];
}
