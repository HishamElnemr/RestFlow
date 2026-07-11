import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_status.dart';
import '../cubit/customers/customers_cubit.dart';
import '../pages/edit_customer_page.dart';

class CustomerItemCard extends StatelessWidget {
  final CustomerEntity customer;

  const CustomerItemCard({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = customer.status == CustomerStatus.active;
    final statusColor = isActive ? AppColors.primary : AppColors.error;
    final statusBgColor = isActive
        ? AppColors.primaryLight.withValues(alpha: 0.1)
        : AppColors.error.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warmGray, width: 1.18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.fullName,
                      style: AppStyles.heading3SemiBold18(context).copyWith(
                        color: AppColors.darkNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customer.phoneNumber,
                      style: AppStyles.body2Medium14(context).copyWith(
                        color: AppColors.mutedGray,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isActive ? 'Active' : 'Inactive',
                        style: AppStyles.captionBold12(context).copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EditCustomerPage(
                              customerId: customer.id,
                            ),
                          ),
                        ).then((result) {
                          if (result == true && context.mounted) {
                            context.read<CustomersCubit>().fetchCustomers();
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.warmGray,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: AppColors.mutedGray,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
              height: 1.18, thickness: 1.18, color: AppColors.warmGray),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: AppColors.mutedGray,
              ),
              const SizedBox(width: 8),
              Text(
                'Joined: ${_formatDate(customer.createdAt)}',
                style: AppStyles.captionBold12(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
