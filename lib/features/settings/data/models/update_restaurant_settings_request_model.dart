import '../../domain/entities/update_restaurant_settings_request_entity.dart';

class UpdateRestaurantSettingsRequestModel
    extends UpdateRestaurantSettingsRequestEntity {
  const UpdateRestaurantSettingsRequestModel({
    super.restaurantName,
    super.cuisineType,
    super.country,
    super.defaultLanguage,
    super.timezone,
    super.currency,
  });

  factory UpdateRestaurantSettingsRequestModel.fromEntity(
    UpdateRestaurantSettingsRequestEntity entity,
  ) {
    return UpdateRestaurantSettingsRequestModel(
      restaurantName: entity.restaurantName,
      cuisineType: entity.cuisineType,
      country: entity.country,
      defaultLanguage: entity.defaultLanguage,
      timezone: entity.timezone,
      currency: entity.currency,
    );
  }

  factory UpdateRestaurantSettingsRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateRestaurantSettingsRequestModel(
      restaurantName: json['restaurantName']?.toString(),
      cuisineType: json['cuisineType']?.toString(),
      country: json['country']?.toString(),
      defaultLanguage: json['defaultLanguage']?.toString(),
      timezone: json['timezone']?.toString(),
      currency: json['currency']?.toString(),
    );
  }

  /// Only serialize fields that are not null to support PATCH requests (partial updates).
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (restaurantName != null) data['restaurantName'] = restaurantName;
    if (cuisineType != null) data['cuisineType'] = cuisineType;
    if (country != null) data['country'] = country;
    if (defaultLanguage != null) data['defaultLanguage'] = defaultLanguage;
    if (timezone != null) data['timezone'] = timezone;
    if (currency != null) data['currency'] = currency;
    return data;
  }
}
