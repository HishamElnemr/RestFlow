import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../notification/presentation/cubit/notifications_list/notifications_list_cubit.dart';
import '../../../notification/presentation/cubit/notifications_list/notifications_list_state.dart';
import '../../../notification/presentation/widgets/notification_item_card.dart';
import '../../../notification/domain/entities/notification_entity.dart';

class OwnerDashboardNotificationsWidget extends StatefulWidget {
  const OwnerDashboardNotificationsWidget({super.key});

  @override
  State<OwnerDashboardNotificationsWidget> createState() =>
      _OwnerDashboardNotificationsWidgetState();
}

class _OwnerDashboardNotificationsWidgetState
    extends State<OwnerDashboardNotificationsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsListCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0DDD6),
          width: 1.18,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE0DDD6),
                  width: 1.18,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.notifications_none_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Recent Notifications',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.notifications);
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List
          BlocBuilder<NotificationsListCubit, NotificationsListState>(
            builder: (context, state) {
              if (state is NotificationsListLoading) {
                return const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is NotificationsListFailure) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Failed to load notifications: \n${state.failure.message}',
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else if (state is NotificationsListLoaded) {
                if (state.notifications.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'No recent notifications.',
                        style: TextStyle(
                          color: AppColors.mutedGray,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  );
                }

                // Show top 3
                final topNotifications = state.notifications.take(3).toList();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: topNotifications.map<Widget>((NotificationEntity notif) {
                    return NotificationItemCard(
                      notification: notif,
                      onTap: () {
                        if (!notif.isRead) {
                          context
                              .read<NotificationsListCubit>()
                              .markAsRead(notif.id);
                        }
                      },
                    );
                  }).toList(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
