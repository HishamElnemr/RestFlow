import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/create_menu_category_request_entity.dart';
import '../../domain/entities/menu_category_list_entity.dart';
import '../cubit/menu_categories/menu_categories_cubit.dart';
import '../cubit/menu_categories/menu_categories_state.dart';

class MenuCategoryFormBottomSheet extends StatefulWidget {
  const MenuCategoryFormBottomSheet({
    super.key,
    this.category,
  });

  final MenuCategoryListEntity? category;

  static Future<void> show(
    BuildContext context, {
    MenuCategoryListEntity? category,
  }) {
    final cubit = context.read<MenuCategoriesCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: MenuCategoryFormBottomSheet(category: category),
      ),
    );
  }

  @override
  State<MenuCategoryFormBottomSheet> createState() =>
      _MenuCategoryFormBottomSheetState();
}

class _MenuCategoryFormBottomSheetState
    extends State<MenuCategoryFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _displayOrderController;

  bool get isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.categoryName);
    _descriptionController =
        TextEditingController(text: widget.category?.description);
    _displayOrderController = TextEditingController(
      text: widget.category?.displayOrder.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _displayOrderController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final request = CreateMenuCategoryRequestEntity(
        categoryName: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        displayOrder: int.tryParse(_displayOrderController.text.trim()),
      );

      if (isEditing) {
        context
            .read<MenuCategoriesCubit>()
            .updateCategory(widget.category!.id, request);
      } else {
        context.read<MenuCategoriesCubit>().createCategory(request);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: BlocConsumer<MenuCategoriesCubit, MenuCategoriesState>(
          listener: (context, state) {
            if (state is MenuCategoriesActionSuccess) {
              Navigator.pop(context);
              context.read<MenuCategoriesCubit>().fetchCategories();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isEditing
                        ? 'Category updated successfully'
                        : 'Category created successfully',
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            } else if (state is MenuCategoriesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is MenuCategoriesLoading &&
                (state.action == MenuCategoriesAction.create ||
                    state.action == MenuCategoriesAction.update);

            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Edit Category' : 'Create Category',
                        style: AppStyles.heading2SemiBold24(context),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(LucideIcons.x),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: _nameController,
                    label: 'Category Name',
                    hintText: 'e.g., Main Dishes',
                    prefixIcon: const Icon(LucideIcons.layout_grid),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _descriptionController,
                    label: 'Description (Optional)',
                    hintText: 'Enter a short description',
                    prefixIcon: const Icon(Icons.description),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _displayOrderController,
                    label: 'Display Order (Optional)',
                    hintText: 'e.g., 1',
                    prefixIcon: const Icon(Icons.format_list_numbered),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val != null && val.trim().isNotEmpty) {
                        if (int.tryParse(val.trim()) == null) {
                          return 'Please enter a valid number';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomPrimaryButton(
                    onPressed: isLoading ? () {} : _submit,
                    text: isEditing ? 'Save Changes' : 'Create Category',
                    isLoading: isLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
