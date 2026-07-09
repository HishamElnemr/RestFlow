import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_cubit.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_state.dart';
import '../../../../core/theme/app_colors.dart';


class RevenueCard extends StatefulWidget {
  const RevenueCard({super.key});

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  String _selectedFilter = 'Today';

  @override
  void initState() {
    super.initState();
    _fetchRevenue();
  }

  void _fetchRevenue() {
    final now = DateTime.now();
    DateTime fromDate;

    switch (_selectedFilter) {
      case 'Week':
        fromDate = now.subtract(const Duration(days: 7));
        break;
      case 'Month':
        fromDate = now.subtract(const Duration(days: 30));
        break;
      case 'Today':
      default:
        fromDate = now;
        break;
    }

    final fromString = fromDate.toIso8601String().split('T')[0];
    final toString = now.toIso8601String().split('T')[0];

    context.read<ReportsCubit>().fetchFinancialSummary(
          from: fromString,
          to: toString,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Total Revenue',
                  style: TextStyle(
                    color: AppColors.whiteOpacity80,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: ['Today', 'Week', 'Month'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return GestureDetector(
                      onTap: () {
                        if (_selectedFilter != filter) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                          _fetchRevenue();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.whiteOpacity80,
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<ReportsCubit, ReportsState>(
            buildWhen: (previous, current) {
              if (current is ReportsLoading &&
                  current.action == ReportsAction.financialSummary) {
                return true;
              }
              if (current is ReportsFailure &&
                  current.action == ReportsAction.financialSummary) {
                return true;
              }
              if (current is FinancialSummarySuccess) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is ReportsLoading &&
                  state.action == ReportsAction.financialSummary) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                );
              }

              if (state is ReportsFailure &&
                  state.action == ReportsAction.financialSummary) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      'Failed to load data',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                );
              }

              if (state is FinancialSummarySuccess) {
                final summary = state.summary;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${summary.totalRevenue.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          summary.revenueGrowth.startsWith('-')
                              ? Icons.trending_down_rounded
                              : Icons.trending_up_rounded,
                          color: AppColors.whiteOpacity80,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          summary.revenueGrowth,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'vs previous period',
                          style: TextStyle(
                            color: AppColors.whiteOpacity80,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
