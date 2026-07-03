import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/features/owner_dashboard/presentation/pages/owner_dashboard_page.dart';
import '../cubit/layout_cubit.dart';

class LayoutPageBody extends StatelessWidget {
  const LayoutPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, int>(
      builder: (context, currentIndex) {
        return IndexedStack(
          index: currentIndex,
          children: const [
            OwnerDashboardPage(),
            Center(child: Text('Orders Page (Coming Soon)')),
            Center(child: Text('Menu Page (Coming Soon)')),
            Center(child: Text('AI Page (Coming Soon)')),
            Center(child: Text('More Settings (Coming Soon)')),
          ],
        );
      },
    );
  }
}
