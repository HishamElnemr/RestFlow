import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification_settings/notification_settings_cubit.dart';
import '../cubit/notification_settings/notification_settings_state.dart';

/// A screen that lets the user view and toggle their notification preferences.
///
/// Reads and writes state via [NotificationSettingsCubit]. Each toggle calls
/// the appropriate helper on the cubit so that only the changed field is sent
/// to the backend (partial PATCH update).
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the current settings when the screen opens.
    context.read<NotificationSettingsCubit>().fetchNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listener: (context, state) {
          if (state is NotificationSettingsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is NotificationSettingsUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Preferences updated successfully.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationSettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Resolve the settings object regardless of which loaded/success
          // state we are in.
          final settings = switch (state) {
            NotificationSettingsLoaded() => state.settings,
            NotificationSettingsUpdating() => state.currentSettings,
            NotificationSettingsUpdateSuccess() => state.settings,
            _ => null,
          };

          if (settings == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unable to load settings.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<NotificationSettingsCubit>()
                        .fetchNotificationSettings(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final isUpdating = state is NotificationSettingsUpdating;

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _SectionHeader(title: 'Communication'),
              _SettingsTile(
                icon: Icons.email_outlined,
                title: 'Email Notifications',
                subtitle: 'Receive updates and alerts via email',
                value: settings.emailNotifications ?? true,
                isLoading: isUpdating,
                onChanged: (value) => context
                    .read<NotificationSettingsCubit>()
                    .toggleEmailNotifications(value: value),
              ),
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'In-App Notifications',
                subtitle: 'Show notifications inside the application',
                value: settings.inAppNotifications ?? true,
                isLoading: isUpdating,
                onChanged: (value) => context
                    .read<NotificationSettingsCubit>()
                    .toggleInAppNotifications(value: value),
              ),
              const Divider(height: 1),
              _SectionHeader(title: 'Alerts'),
              _SettingsTile(
                icon: Icons.inventory_2_outlined,
                title: 'Inventory Alerts',
                subtitle: 'Get notified about low-stock and inventory changes',
                value: settings.inventoryAlerts ?? true,
                isLoading: isUpdating,
                onChanged: (value) => context
                    .read<NotificationSettingsCubit>()
                    .toggleInventoryAlerts(value: value),
              ),
              _SettingsTile(
                icon: Icons.warning_amber_outlined,
                title: 'Important Alerts',
                subtitle: 'Receive critical system notifications',
                value: settings.importantAlerts ?? true,
                isLoading: isUpdating,
                onChanged: (value) => context
                    .read<NotificationSettingsCubit>()
                    .toggleImportantAlerts(value: value),
              ),
              const Divider(height: 1),
              _SectionHeader(title: 'AI Features'),
              _SettingsTile(
                icon: Icons.auto_awesome_outlined,
                title: 'AI Insights Notifications',
                subtitle: 'Receive AI-generated insights and recommendations',
                value: settings.aiInsightsNotifications ?? false,
                isLoading: isUpdating,
                onChanged: (value) => context
                    .read<NotificationSettingsCubit>()
                    .toggleAiInsightsNotifications(value: value),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.isLoading = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final bool isLoading;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: theme.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: theme.colorScheme.primary,
            ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
