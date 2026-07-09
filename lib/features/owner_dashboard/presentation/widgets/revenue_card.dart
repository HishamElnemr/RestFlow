import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/dummy_data/financial_summary_dummy.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_cubit.dart';
import 'package:rest_flow/features/reports/presentation/cubit/reports/reports_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/theme/app_colors.dart';
import 'revenue_card_content.dart';
import 'revenue_card_header.dart';

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

  void _onFilterChanged(String newFilter) {
    if (_selectedFilter != newFilter) {
      setState(() {
        _selectedFilter = newFilter;
      });
      _fetchRevenue();
    }
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
          RevenueCardHeader(
            selectedFilter: _selectedFilter,
            onFilterChanged: _onFilterChanged,
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
              if (state is ReportsFailure &&
                  state.action == ReportsAction.financialSummary) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      state.failure.message,
                      style: const TextStyle(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final isLoading = state is ReportsInitial ||
                  (state is ReportsLoading &&
                      state.action == ReportsAction.financialSummary);

              var displaySummary = FinancialSummaryDummy.dummy;

              if (state is FinancialSummarySuccess) {
                displaySummary = state.summary;
              }

              return Skeletonizer(
                enabled: isLoading,
                effect: ShimmerEffect(
                  baseColor: AppColors.white.withOpacity(0.3),
                  highlightColor: AppColors.whiteOpacity80,
                ),
                child: RevenueCardContent(summary: displaySummary),
              );
            },
          ),
        ],
      ),
    );
  }
}
