import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/layout_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/layout_page_body.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LayoutCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: const LayoutPageBody(),
        bottomNavigationBar: BlocBuilder<LayoutCubit, int>(
          builder: (context, currentIndex) {
            return CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<LayoutCubit>().changeTab(index);
              },
            );
          },
        ),
      ),
    );
  }
}
