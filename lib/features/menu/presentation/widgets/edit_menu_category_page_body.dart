import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../menu/domain/entities/create_menu_category_request_entity.dart';
import '../../../menu/domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_categories/menu_categories_state.dart';
import 'menu_category_form_fields.dart';
import 'menu_category_save_button.dart';

class EditMenuCategoryPageBody extends StatefulWidget {
  const EditMenuCategoryPageBody({
    super.key,
    required this.category,
  });

  final MenuCategoryListEntity category;

  @override
  State<EditMenuCategoryPageBody> createState() =>
      _EditMenuCategoryPageBodyState();
}

class _EditMenuCategoryPageBodyState extends State<EditMenuCategoryPageBody> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String? _description;
  late int? _displayOrder;

  @override
  void initState() {
    super.initState();
    _name = widget.category.categoryName;
    _description = widget.category.description;
    _displayOrder = widget.category.displayOrder;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCategoriesCubit, MenuCategoriesState>(
      listener: (context, state) {
        if (state is MenuCategoriesActionSuccess &&
            state.action == MenuCategoriesAction.update) {
          log('[EditMenuCategoryPageBody] update SUCCESS -> popping with true');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category updated successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is MenuCategoriesFailure &&
            state.action == MenuCategoriesAction.update) {
          log('[EditMenuCategoryPageBody] update FAILED: ${state.failure.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is MenuCategoriesLoading &&
            state.action == MenuCategoriesAction.update;

        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    title: 'Edit Category',
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
                label: 'Save Changes',
                isLoading: isSaving,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    log('[EditMenuCategoryPageBody] Save pressed: name=$_name');
                    final request = CreateMenuCategoryRequestEntity(
                      categoryName: _name,
                      description: _description,
                      displayOrder: _displayOrder,
                    );
                    context
                        .read<MenuCategoriesCubit>()
                        .updateCategory(widget.category.id, request);
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
