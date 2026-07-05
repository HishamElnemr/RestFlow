import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/notifications_list/notifications_list_cubit.dart';
import '../cubit/notifications_list/notifications_list_state.dart';
import 'notification_item_card.dart';

class NotificationsPageBody extends StatefulWidget {
  const NotificationsPageBody({super.key});

  @override
  State<NotificationsPageBody> createState() => _NotificationsPageBodyState();
}

class _NotificationsPageBodyState extends State<NotificationsPageBody> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsListCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderActions(context),
        Expanded(
          child: BlocBuilder<NotificationsListCubit, NotificationsListState>(
            builder: (context, state) {
              if (state is NotificationsListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationsListFailure) {
                return Center(
                  child: Text(
                    'Failed to load notifications: ${state.failure.message}',
                    style: const TextStyle(color: AppColors.error),
                  ),
                );
              } else if (state is NotificationsListLoaded) {
                if (state.notifications.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notifications yet.',
                      style: TextStyle(
                        color: AppColors.mutedGray,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<NotificationsListCubit>().fetchNotifications();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final notif = state.notifications[index];
                      return NotificationItemCard(
                        notification: notif,
                        onTap: () {
                          if (!notif.isRead) {
                            context.read<NotificationsListCubit>().markAsRead(notif.id);
                          }
                        },
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<NotificationsListCubit, NotificationsListState>(
            builder: (context, state) {
              if (state is NotificationsListLoaded && state.unreadCount > 0) {
                return Text(
                  'You have ${state.unreadCount} unread',
                  style: const TextStyle(
                    color: AppColors.mutedGray,
                    fontFamily: 'Inter',
                    fontSize: 14,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          TextButton(
            onPressed: () {
              context.read<NotificationsListCubit>().markAllAsRead();
            },
            child: const Text(
              'Mark all as read',
              style: TextStyle(
                color: AppColors.primary,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
