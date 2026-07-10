import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/settings/presentation/widgets/notification_item_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/notifications_list/notifications_list_cubit.dart';
import '../cubit/notifications_list/notifications_list_state.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';

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
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Notifications',
          showBackButton: true,
        ),
        SliverToBoxAdapter(
          child: _buildHeaderActions(context),
        ),
        BlocBuilder<NotificationsListCubit, NotificationsListState>(
          builder: (context, state) {
            if (state is NotificationsListLoading) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is NotificationsListFailure) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Failed to load notifications: ${state.failure.message}',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              );
            } else if (state is NotificationsListLoaded) {
              if (state.notifications.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No notifications yet.',
                      style: TextStyle(
                        color: AppColors.mutedGray,
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.warmGray, width: 1.18),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: state.notifications.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1.18,
                        thickness: 1.18,
                        color: AppColors.warmGray,
                      ),
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
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.read<NotificationsListCubit>().markAllAsRead();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
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
        ],
      ),
    );
  }
}
