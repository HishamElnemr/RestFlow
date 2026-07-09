import 'package:flutter/material.dart';

import '../../../../core/widgets/filter_tabs_bar.dart';
import '../../domain/enums/order_status.dart';

class OrdersFilterTabs extends StatelessWidget {
  const OrdersFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  final OrderStatus? selectedStatus;
  final ValueChanged<OrderStatus?> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return FilterTabsBar<OrderStatus>(
      selectedValue: selectedStatus,
      onChanged: onStatusChanged,
      items: const [
        FilterTabItem(label: 'Pending', value: OrderStatus.pending),
        FilterTabItem(label: 'Completed', value: OrderStatus.completed),
        FilterTabItem(label: 'Cancelled', value: OrderStatus.cancelled),
      ],
    );
  }
}
