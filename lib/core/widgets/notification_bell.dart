import 'package:flutter/material.dart';

import '../routes/routes_name.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, this.onTap, this.iconSize = 24});

  final VoidCallback? onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => _navigateToAlerts(context),
      icon: Icon(
        Icons.notifications_outlined,
        size: iconSize,
      ),
    );
  }

  void _navigateToAlerts(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.lowStockAlerts);
  }
}
