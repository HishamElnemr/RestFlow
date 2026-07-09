import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_flow/core/services/getit_services.dart';
import 'package:rest_flow/core/theme/app_colors.dart';
import 'package:rest_flow/features/ai/presentation/cubit/ai_chat/ai_chat_cubit.dart';

import 'package:rest_flow/core/utils/app_styles.dart';

import '../widgets/ai_page_body.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AiChatCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.darkNavy, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'AI Business Advisor',
            style: AppStyles.heading3SemiBold18(context).copyWith(
              color: AppColors.darkNavy,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.18),
            child: Container(
              color: AppColors.warmGray,
              height: 1.18,
            ),
          ),
        ),
        body: const SafeArea(
          child: AiPageBody(),
        ),
      ),
    );
  }
}
