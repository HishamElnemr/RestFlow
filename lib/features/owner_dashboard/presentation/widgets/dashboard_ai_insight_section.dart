import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/ai/presentation/cubit/ai_dashboard/ai_dashboard_cubit.dart';
import 'package:rest_flow/features/ai/presentation/cubit/ai_dashboard/ai_dashboard_state.dart';
import 'package:rest_flow/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'ai_insight_card.dart';

class DashboardAiInsightSection extends StatelessWidget {
  const DashboardAiInsightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDashboardCubit, AiDashboardState>(
      builder: (context, state) {
        final isLoading = state is AiDashboardLoading;
        final insightText =
            state is AiDashboardSuccess && state.insights.isNotEmpty
                ? state.insights.first.insight
                : 'Your AI insights will appear here.';

        return Skeletonizer(
          enabled: isLoading,
          child: AiInsightCard(
            insightText: insightText,
            onViewAllTap: () {
              context.read<LayoutCubit>().changeTab(3);
            },
          ),
        );
      },
    );
  }
}
