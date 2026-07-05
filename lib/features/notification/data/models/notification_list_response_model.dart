import '../../domain/entities/notification_list_response_entity.dart';
import 'notification_model.dart';

class NotificationListResponseModel extends NotificationListResponseEntity {
  const NotificationListResponseModel({
    required super.notifications,
    required super.unreadCount,
    required super.totalCount,
  });

  factory NotificationListResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationListResponseModel(
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      unreadCount: json['unreadCount'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications':
          notifications.map((e) => (e as NotificationModel).toJson()).toList(),
      'unreadCount': unreadCount,
      'totalCount': totalCount,
    };
  }
}
