import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/settings/domain/entities/notification_settings_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/notification_settings/notification_settings_cubit.dart';
import '../cubit/notification_settings/notification_settings_state.dart';
import 'notification_toggle_tile.dart';

class NotificationSettingsForm extends StatefulWidget {
  const NotificationSettingsForm({
    super.key,
    required this.initialSettings,
  });

  final NotificationSettingsEntity initialSettings;

  @override
  State<NotificationSettingsForm> createState() =>
      _NotificationSettingsFormState();
}

class _NotificationSettingsFormState extends State<NotificationSettingsForm> {
  late bool _inAppNotifications;
  late bool _inventoryAlerts;
  late bool _importantAlerts;
  
  // Local only states for visual toggle
  bool _emailAlerts = true;
  bool _orderAlerts = true;
  bool _aiInsights = false;

  @override
  void initState() {
    super.initState();
    _inAppNotifications = widget.initialSettings.inAppNotifications ?? false;
    _inventoryAlerts = widget.initialSettings.inventoryAlerts ?? false;
    _importantAlerts = widget.initialSettings.importantAlerts ?? false;
  }

  void _savePreferences() {
    final newSettings = NotificationSettingsEntity(
      inAppNotifications: _inAppNotifications,
      inventoryAlerts: _inventoryAlerts,
      importantAlerts: _importantAlerts,
    );
    context.read<NotificationSettingsCubit>().updateNotificationSettings(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationSettingsCubit, NotificationSettingsState>(
      listener: (context, state) {
        if (state is NotificationSettingsUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Preferences saved successfully.'),
              backgroundColor: AppColors.successBright,
            ),
          );
        } else if (state is NotificationSettingsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The 3 fields connected to the backend logic
          NotificationToggleTile(
            title: 'In-app Notifications',
            subtitle: 'Badges and popups inside the dashboard',
            value: _inAppNotifications,
            onChanged: (val) {
              setState(() {
                _inAppNotifications = val;
              });
            },
          ),
          NotificationToggleTile(
            title: 'Low Stock Alerts',
            subtitle: 'Notify when inventory falls below the set threshold',
            value: _inventoryAlerts,
            onChanged: (val) {
              setState(() {
                _inventoryAlerts = val;
              });
            },
          ),
          NotificationToggleTile(
            title: 'System Announcements',
            subtitle: 'Maintenance windows and platform updates',
            value: _importantAlerts,
            onChanged: (val) {
              setState(() {
                _importantAlerts = val;
              });
            },
          ),
          
          // UI-only toggles
          NotificationToggleTile(
            title: 'Email Alerts',
            subtitle: 'Important updates and daily summaries by email',
            value: _emailAlerts,
            onChanged: (val) {
              setState(() {
                _emailAlerts = val;
              });
            },
          ),
          NotificationToggleTile(
            title: 'Order Alerts',
            subtitle: 'Notify when orders are completed or cancelled',
            value: _orderAlerts,
            onChanged: (val) {
              setState(() {
                _orderAlerts = val;
              });
            },
          ),
          NotificationToggleTile(
            title: 'AI Insights',
            subtitle: 'Weekly predictive analytics and smart suggestions',
            value: _aiInsights,
            onChanged: (val) {
              setState(() {
                _aiInsights = val;
              });
            },
          ),
          const SizedBox(height: 32),
          BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
            builder: (context, state) {
              final isUpdating = state is NotificationSettingsUpdating;
              return ElevatedButton.icon(
                onPressed: isUpdating ? null : _savePreferences,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: isUpdating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save_outlined, size: 20),
                label: Text(
                  'Save Preferences',
                  style: AppStyles.body2Medium14(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
