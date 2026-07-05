import 'package:equatable/equatable.dart';
import 'notification_entity.dart';

class NotificationListResponseEntity extends Equatable {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final int totalCount;

  const NotificationListResponseEntity({
    required this.notifications,
    required this.unreadCount,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [notifications, unreadCount, totalCount];
}
