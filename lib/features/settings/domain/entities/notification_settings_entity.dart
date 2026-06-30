import 'package:equatable/equatable.dart';

class NotificationSettingsEntity extends Equatable {
  const NotificationSettingsEntity({
    this.emailNotifications,
    this.inAppNotifications,
    this.aiInsightsNotifications,
    this.inventoryAlerts,
    this.importantAlerts,
  });

  final bool? emailNotifications;
  final bool? inAppNotifications;
  final bool? aiInsightsNotifications;
  final bool? inventoryAlerts;
  final bool? importantAlerts;

  NotificationSettingsEntity copyWith({
    bool? emailNotifications,
    bool? inAppNotifications,
    bool? aiInsightsNotifications,
    bool? inventoryAlerts,
    bool? importantAlerts,
  }) {
    return NotificationSettingsEntity(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      inAppNotifications: inAppNotifications ?? this.inAppNotifications,
      aiInsightsNotifications:
          aiInsightsNotifications ?? this.aiInsightsNotifications,
      inventoryAlerts: inventoryAlerts ?? this.inventoryAlerts,
      importantAlerts: importantAlerts ?? this.importantAlerts,
    );
  }

  @override
  List<Object?> get props => [
    emailNotifications,
    inAppNotifications,
    aiInsightsNotifications,
    inventoryAlerts,
    importantAlerts,
  ];
}
