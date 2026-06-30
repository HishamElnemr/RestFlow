import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/low_stock_alert_entity.dart';
import '../cubit/low_stock/low_stock_cubit.dart';
import '../cubit/low_stock/low_stock_state.dart';

class LowStockAlertsPage extends StatefulWidget {
  const LowStockAlertsPage({super.key});

  @override
  State<LowStockAlertsPage> createState() => _LowStockAlertsPageState();
}

class _LowStockAlertsPageState extends State<LowStockAlertsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<LowStockCubit>().fetchLowStockAlerts());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Low Stock Alerts'),
        backgroundColor: colorScheme.surface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<LowStockCubit, LowStockState>(
            builder: (context, state) {
              if (state is LowStockLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LowStockFailure) {
                return _stateMessage(context, state.failure.message);
              }
              if (state is LowStockSuccess) {
                return _alertsList(context, state.alerts);
              }
              return _stateMessage(context, 'No alerts yet.');
            },
          ),
        ),
      ),
    );
  }

  Widget _alertsList(BuildContext context, List<LowStockAlertEntity> alerts) {
    if (alerts.isEmpty) {
      return _stateMessage(context, 'No low stock alerts.');
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alert.itemName, style: AppStyles.section(context)),
              const SizedBox(height: 6),
              Text(alert.categoryName, style: AppStyles.label(context)),
              const SizedBox(height: 6),
              Text(
                'Qty: ${alert.currentQuantity} ${alert.unitOfMeasure} | Min: ${alert.minimumQuantity}',
                style: AppStyles.body(context),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemCount: alerts.length,
    );
  }

  Widget _stateMessage(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(message, style: AppStyles.body(context)),
      ),
    );
  }
}
