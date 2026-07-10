import 'package:equatable/equatable.dart';
import 'package:rest_flow/features/settings/domain/entities/notification_entity.dart';
import 'package:rest_flow/features/settings/domain/entities/notification_list_response_entity.dart';

import '../../../../../core/errors/app_failure.dart';


abstract class NotificationsListState extends Equatable {
  const NotificationsListState();

  @override
  List<Object?> get props => [];
}

class NotificationsListInitial extends NotificationsListState {
  const NotificationsListInitial();
}

class NotificationsListLoading extends NotificationsListState {
  const NotificationsListLoading();
}

class NotificationsListLoaded extends NotificationsListState {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final int totalCount;

  const NotificationsListLoaded({
    required this.notifications,
    required this.unreadCount,
    required this.totalCount,
  });

  factory NotificationsListLoaded.fromEntity(
      NotificationListResponseEntity entity) {
    return NotificationsListLoaded(
      notifications: entity.notifications,
      unreadCount: entity.unreadCount,
      totalCount: entity.totalCount,
    );
  }

  NotificationsListLoaded copyWith({
    List<NotificationEntity>? notifications,
    int? unreadCount,
    int? totalCount,
  }) {
    return NotificationsListLoaded(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [notifications, unreadCount, totalCount];
}

class NotificationsListFailure extends NotificationsListState {
  final AppFailure failure;

  const NotificationsListFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
