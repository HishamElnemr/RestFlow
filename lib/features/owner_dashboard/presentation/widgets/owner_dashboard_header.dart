import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../notification/presentation/cubit/notifications_list/notifications_list_cubit.dart';
import '../../../notification/presentation/cubit/notifications_list/notifications_list_state.dart';
import '../../../notification/presentation/cubit/restaurant_settings/restaurant_settings_cubit.dart';
import '../../../notification/presentation/cubit/restaurant_settings/restaurant_settings_state.dart';
import '../../../notification/presentation/cubit/user_profile_settings/user_profile_settings_cubit.dart';
import '../../../notification/presentation/cubit/user_profile_settings/user_profile_settings_state.dart';
import 'header_avatar_button.dart';
import 'header_notification_button.dart';

class OwnerDashboardHeader extends StatelessWidget {
  const OwnerDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 13.18, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
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
          BlocBuilder<RestaurantSettingsCubit, RestaurantSettingsState>(
            builder: (context, state) {
              String restaurantName = 'The Golden Spool';
              bool isLoading = state is RestaurantSettingsLoading;
              
              if (state is RestaurantSettingsLoaded) {
                restaurantName = state.settings.restaurantName;
                if (restaurantName.trim().isEmpty) {
                  restaurantName = 'The Golden Spool';
                }
              }

              return Skeletonizer(
                enabled: isLoading,
                child: Text(
                  restaurantName,
                  style: AppStyles.heading3Medium22(context).copyWith(
                    color: AppColors.darkNavy,
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<NotificationsListCubit, NotificationsListState>(
                builder: (context, state) {
                  int badgeCount = 0;
                  if (state is NotificationsListLoaded) {
                    badgeCount = state.unreadCount;
                  }
                  return HeaderNotificationButton(
                    badgeCount: badgeCount,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.notifications);
                    },
                  );
                },
              ),
              const SizedBox(width: 12),
              BlocBuilder<UserProfileSettingsCubit, UserProfileSettingsState>(
                builder: (context, state) {
                  String initials = 'JD';
                  if (state is UserProfileSettingsLoaded) {
                    initials = state.profile.fullName.getInitials;
                  }
                  return HeaderAvatarButton(
                    initials: initials,
                    onTap: () {
                      // Handle profile tap
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
