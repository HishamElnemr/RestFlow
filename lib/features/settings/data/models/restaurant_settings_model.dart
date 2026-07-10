import '../../domain/entities/restaurant_settings_entity.dart';

class RestaurantSettingsModel extends RestaurantSettingsEntity {
  const RestaurantSettingsModel({
    required super.restaurantName,
    super.restaurantLogoUrl,
    super.cuisineType,
    required super.country,
    required super.defaultLanguage,
    required super.timezone,
    required super.currency,
  });

  RestaurantSettingsEntity toEntity() {
    return RestaurantSettingsEntity(
      restaurantName: restaurantName,
      restaurantLogoUrl: restaurantLogoUrl,
      cuisineType: cuisineType,
      country: country,
      defaultLanguage: defaultLanguage,
      timezone: timezone,
      currency: currency,
    );
  }

  factory RestaurantSettingsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantSettingsModel(
      restaurantName: (json['restaurantName'] ?? '').toString(),
      restaurantLogoUrl: json['restaurantLogoUrl']?.toString(),
      cuisineType: json['cuisineType']?.toString(),
      country: (json['country'] ?? '').toString(),
      defaultLanguage: (json['defaultLanguage'] ?? 'en').toString(),
      timezone: (json['timezone'] ?? 'UTC').toString(),
      currency: (json['currency'] ?? 'USD').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'restaurantName': restaurantName,
        'restaurantLogoUrl': restaurantLogoUrl,
        'cuisineType': cuisineType,
        'country': country,
        'defaultLanguage': defaultLanguage,
        'timezone': timezone,
        'currency': currency,
      };
}
