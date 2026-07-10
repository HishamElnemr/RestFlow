import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_sliver_app_bar.dart';
import 'more_list_section.dart';

class MorePageBody extends StatelessWidget {
  const MorePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: 'More',
          showBackButton: false,
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: MoreListSection(),
          ),
        ),
      ],
    );
  }
}
