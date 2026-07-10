import 'package:rest_flow/features/settings/domain/entities/notification_settings_entity.dart';

class NotificationSettingsModel extends NotificationSettingsEntity {
  const NotificationSettingsModel({
    super.emailNotifications,
    super.inAppNotifications,
    super.aiInsightsNotifications,
    super.inventoryAlerts,
    super.importantAlerts,
  });

  factory NotificationSettingsModel.fromEntity(
    NotificationSettingsEntity entity,
  ) {
    return NotificationSettingsModel(
      emailNotifications: entity.emailNotifications,
      inAppNotifications: entity.inAppNotifications,
      aiInsightsNotifications: entity.aiInsightsNotifications,
      inventoryAlerts: entity.inventoryAlerts,
      importantAlerts: entity.importantAlerts,
    );
  }

  NotificationSettingsEntity toEntity() {
    return NotificationSettingsEntity(
      emailNotifications: emailNotifications,
      inAppNotifications: inAppNotifications,
      aiInsightsNotifications: aiInsightsNotifications,
      inventoryAlerts: inventoryAlerts,
      importantAlerts: importantAlerts,
    );
  }

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      emailNotifications: json['emailNotifications'] as bool?,
      inAppNotifications: json['inAppNotifications'] as bool?,
      aiInsightsNotifications: json['aiInsightsNotifications'] as bool?,
      inventoryAlerts: json['inventoryAlerts'] as bool?,
      importantAlerts: json['importantAlerts'] as bool?,
    );
  }

  /// Serializes only non-null fields so the PATCH request only updates
  /// the fields the user has explicitly changed (partial update).
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (emailNotifications != null) {
      json['emailNotifications'] = emailNotifications;
    }
    if (inAppNotifications != null) {
      json['inAppNotifications'] = inAppNotifications;
    }
    if (aiInsightsNotifications != null) {
      json['aiInsightsNotifications'] = aiInsightsNotifications;
    }
    if (inventoryAlerts != null) {
      json['inventoryAlerts'] = inventoryAlerts;
    }
    if (importantAlerts != null) {
      json['importantAlerts'] = importantAlerts;
    }
    return json;
  }
}
