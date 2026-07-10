import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/settings/domain/entities/notification_settings_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../cubit/notification_settings/notification_settings_cubit.dart';
import '../cubit/notification_settings/notification_settings_state.dart';
import 'notification_settings_form.dart';

class NotificationSettingsPageBody extends StatelessWidget {
  const NotificationSettingsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Notification Preferences',
          showBackButton: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Choose which alerts you personally receive',
              style: AppStyles.body2Medium14(context).copyWith(
                color: AppColors.mutedGray,
              ),
            ),
          ),
        ),
        BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
          builder: (context, state) {
            final isLoading = state is NotificationSettingsLoading ||
                state is NotificationSettingsInitial;
            final isError = state is NotificationSettingsFailure;
            NotificationSettingsEntity settings = const NotificationSettingsEntity();

            if (state is NotificationSettingsLoaded) {
              settings = state.settings;
            } else if (state is NotificationSettingsUpdateSuccess) {
              settings = state.settings;
            } else if (state is NotificationSettingsUpdating) {
              settings = state.currentSettings;
            }

            if (isError) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.failure.message,
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              );
            }

            return Skeletonizer.sliver(
              enabled: isLoading,
              containersColor: Colors.grey.shade100,
              ignoreContainers: false,
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade50,
              ),
              child: SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: NotificationSettingsForm(
                    initialSettings: settings,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
