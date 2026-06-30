import 'package:equatable/equatable.dart';

class RestaurantSettingsEntity extends Equatable {
  const RestaurantSettingsEntity({
    required this.restaurantName,
    this.restaurantLogoUrl,
    this.cuisineType,
    required this.country,
    required this.defaultLanguage,
    required this.timezone,
    required this.currency,
  });

  final String restaurantName;
  final String? restaurantLogoUrl;
  final String? cuisineType;
  final String country;
  final String defaultLanguage;
  final String timezone;
  final String currency;

  @override
  List<Object?> get props => [
        restaurantName,
        restaurantLogoUrl,
        cuisineType,
        country,
        defaultLanguage,
        timezone,
        currency,
      ];
}
