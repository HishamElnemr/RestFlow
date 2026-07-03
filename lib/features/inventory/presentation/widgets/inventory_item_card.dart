import 'package:flutter/material.dart';
import 'package:rest_flow/features/inventory/domain/entities/inventory_item_list_entity.dart';

import '../../../../core/theme/app_colors.dart';

class InventoryItemCard extends StatelessWidget {
  const InventoryItemCard({super.key, required this.item});

  final InventoryItemListEntity item;

  @override
  Widget build(BuildContext context) {
    final bool isLowStock = item.currentQuantity <= item.minimumQuantity &&
        item.currentQuantity > 0;
    final bool isOutOfStock = item.currentQuantity == 0;

    Color statusColor = AppColors.successBright;
    Color statusBgColor = AppColors.successBg;
    String statusLabel = 'GOOD';

    if (isOutOfStock) {
      statusColor = AppColors.error;
      statusBgColor = AppColors.googleRed;
      statusLabel = 'OUT';
    } else if (isLowStock) {
      statusColor = AppColors.amber;
      statusBgColor = AppColors.warningBg;
      statusLabel = 'LOW';
    }

    final double totalValue = item.currentQuantity * item.costPerUnit;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: statusColor, width: 3.5),
          top: const BorderSide(color: AppColors.borderLight, width: 1.18),
          right: const BorderSide(color: AppColors.borderLight, width: 1.18),
          bottom: const BorderSide(color: AppColors.borderLight, width: 1.18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemName,
                        style: const TextStyle(
                          color: AppColors.darkNavy,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.categoryName,
                        style: const TextStyle(
                          color: AppColors.mutedGray,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${item.currentQuantity} ${item.unitOfMeasure}',
                      style: TextStyle(
                        color: statusColor == AppColors.successBright
                            ? AppColors.darkNavy
                            : statusColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Min: ${item.minimumQuantity} ${item.unitOfMeasure}',
                      style: const TextStyle(
                        color: AppColors.mutedGray,
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${item.costPerUnit.toStringAsFixed(2)}/${item.unitOfMeasure}',
                  style: const TextStyle(
                    color: AppColors.mutedGray,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  'Total value: \$${totalValue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.mutedGray,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
