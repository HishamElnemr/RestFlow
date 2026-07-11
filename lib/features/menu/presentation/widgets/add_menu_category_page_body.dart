import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../menu/domain/entities/create_menu_category_request_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_categories/menu_categories_state.dart';
import 'menu_category_form_fields.dart';
import 'menu_category_save_button.dart';

class AddMenuCategoryPageBody extends StatefulWidget {
  const AddMenuCategoryPageBody({super.key});

  @override
  State<AddMenuCategoryPageBody> createState() =>
      _AddMenuCategoryPageBodyState();
}

class _AddMenuCategoryPageBodyState extends State<AddMenuCategoryPageBody> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String? _description;
  int? _displayOrder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCategoriesCubit, MenuCategoriesState>(
      listener: (context, state) {
        if (state is MenuCategoriesActionSuccess &&
            state.action == MenuCategoriesAction.create) {
          log('[AddMenuCategoryPageBody] create SUCCESS -> popping with true');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category added successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is MenuCategoriesFailure &&
            state.action == MenuCategoriesAction.create) {
          log('[AddMenuCategoryPageBody] create FAILED: ${state.failure.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isCreating = state is MenuCategoriesLoading &&
            state.action == MenuCategoriesAction.create;

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Add Category',
                    showBackButton: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Form(
                        key: _formKey,
                        child: MenuCategoryFormFields(
                          initialName: _name,
                          initialDescription: _description,
                          initialDisplayOrder: _displayOrder,
                          onNameChanged: (val) => _name = val,
                          onDescriptionChanged: (val) => _description = val,
                          onDisplayOrderChanged: (val) => _displayOrder = val,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 32.0,
              ),
              child: MenuCategorySaveButton(
                label: 'Add Category',
                isLoading: isCreating,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    log('[AddMenuCategoryPageBody] Save pressed: name=$_name');
                    final request = CreateMenuCategoryRequestEntity(
                      categoryName: _name,
                      description: _description,
                      displayOrder: _displayOrder,
                    );
                    context.read<MenuCategoriesCubit>().createCategory(request);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
