import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const NotificationItemCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getNotificationConfig(notification.type);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.white
              : AppColors.electricBlue.withOpacity(0.1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: config.bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  config.icon,
                  color: config.iconColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppStyles.body2Medium14(context).copyWith(
                            color: AppColors.darkNavy,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: AppStyles.captionBold12(context).copyWith(
                      color: AppColors.mutedGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(notification.createdAt),
                    style: AppStyles.captionBold12(context).copyWith(
                      color: AppColors.mutedGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _NotificationConfig _getNotificationConfig(String type) {
    switch (type) {
      case 'Inventory':
        return _NotificationConfig(
          bgColor: AppColors.cream,
          iconColor: AppColors.darkOrange,
          icon: Icons.warning_amber_rounded,
        );
      case 'Order':
        return _NotificationConfig(
          bgColor: AppColors.primaryOpacity20,
          iconColor: AppColors.primary,
          icon: Icons.shopping_bag_outlined,
        );
      case 'User':
      case 'General':
      default:
        return _NotificationConfig(
          bgColor: AppColors.surfaceLight,
          iconColor: AppColors.mutedGray,
          icon: Icons.notifications_none_rounded,
        );
    }
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _NotificationConfig {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  _NotificationConfig({
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });
}
