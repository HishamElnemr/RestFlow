import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/inventory/presentation/cubit/low_stock_count/low_stock_count_cubit.dart';
import '../../features/inventory/presentation/cubit/low_stock_count/low_stock_count_state.dart';
import '../routes/routes_name.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key, this.onTap, this.iconSize = 24});

  final VoidCallback? onTap;
  final double iconSize;

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<LowStockCountCubit>().fetchLowStockCount(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LowStockCountCubit, LowStockCountState>(
      builder: (context, state) {
        final count = state is LowStockCountSuccess ? state.count : 0;
        final showBadge = count > 0;

        return IconButton(
          onPressed: widget.onTap ?? () => _navigateToAlerts(context),
          icon: badges.Badge(
            showBadge: showBadge,
            position: badges.BadgePosition.topEnd(top: -6, end: -6),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Theme.of(context).colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            ),
            badgeContent: Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            child: Icon(
              Icons.notifications_outlined,
              size: widget.iconSize,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      },
    );
  }

  void _navigateToAlerts(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.lowStockAlerts);
  }
}
