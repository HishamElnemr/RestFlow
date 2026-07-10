import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/widgets/custom_sliver_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_ai_dashboard.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/ai_dashboard/ai_dashboard_cubit.dart';
import '../cubit/ai_dashboard/ai_dashboard_state.dart';
import 'ai_dashboard_ask_advisor_button.dart';
import 'ai_insight_card.dart';
import 'ai_insights_section_header.dart';

class AiDashboardPageBody extends StatefulWidget {
  const AiDashboardPageBody({super.key});

  @override
  State<AiDashboardPageBody> createState() => _AiDashboardPageBodyState();
}

class _AiDashboardPageBodyState extends State<AiDashboardPageBody> {
  @override
  void initState() {
    super.initState();
    context.read<AiDashboardCubit>().fetchInsights();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDashboardCubit, AiDashboardState>(
      builder: (context, state) {
        final isLoading =
            state is AiDashboardLoading || state is AiDashboardInitial;
        final isError = state is AiDashboardError;
        final insights = state is AiDashboardSuccess
            ? state.insights
            : DummyAiDashboard.insights;

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    const CustomSliverAppBar(
                      title: 'AI Co-Pilot',
                      showBackButton: false,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            AiInsightsSectionHeader(
                              onRefresh: () => context
                                  .read<AiDashboardCubit>()
                                  .fetchInsights(),
                            ),
                            const SizedBox(height: 16),
                            if (isError)
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 32),
                                  child: Text(
                                    state.failure.message,
                                    style: AppStyles.body2Medium14(context)
                                        .copyWith(
                                      color: AppColors.error,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!isError)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final int itemIndex = index ~/ 2;
                              if (index.isEven) {
                                return AiInsightCard(
                                    insight: insights[itemIndex]);
                              }
                              return const SizedBox(height: 16);
                            },
                            childCount:
                                insights.isEmpty ? 0 : insights.length * 2 - 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (!isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: AiDashboardAskAdvisorButton(),
                ),
            ],
          ),
        );
      },
    );
  }
}
