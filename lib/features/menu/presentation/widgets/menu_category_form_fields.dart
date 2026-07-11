import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'menu_category_text_field.dart';

class MenuCategoryFormFields extends StatefulWidget {
  const MenuCategoryFormFields({
    super.key,
    required this.initialName,
    this.initialDescription,
    this.initialDisplayOrder,
    required this.onNameChanged,
    required this.onDescriptionChanged,
    required this.onDisplayOrderChanged,
  });

  final String initialName;
  final String? initialDescription;
  final int? initialDisplayOrder;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String?> onDescriptionChanged;
  final ValueChanged<int?> onDisplayOrderChanged;

  @override
  State<MenuCategoryFormFields> createState() => _MenuCategoryFormFieldsState();
}

class _MenuCategoryFormFieldsState extends State<MenuCategoryFormFields> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _displayOrderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
    _displayOrderController = TextEditingController(
      text: widget.initialDisplayOrder != null
          ? widget.initialDisplayOrder.toString()
          : '',
    );
  }

  @override
  void didUpdateWidget(covariant MenuCategoryFormFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialName != widget.initialName ||
        oldWidget.initialDescription != widget.initialDescription ||
        oldWidget.initialDisplayOrder != widget.initialDisplayOrder) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (oldWidget.initialName != widget.initialName) {
          _nameController.text = widget.initialName;
        }
        if (oldWidget.initialDescription != widget.initialDescription) {
          _descriptionController.text = widget.initialDescription ?? '';
        }
        if (oldWidget.initialDisplayOrder != widget.initialDisplayOrder) {
          _displayOrderController.text = widget.initialDisplayOrder != null
              ? widget.initialDisplayOrder.toString()
              : '';
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _displayOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkNavy.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuCategoryTextField(
            label: 'Category Name',
            controller: _nameController,
            onChanged: widget.onNameChanged,
            hintText: 'e.g. Main Course, Desserts',
            validator: (val) =>
                (val == null || val.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          MenuCategoryTextField(
            label: 'Description (Optional)',
            controller: _descriptionController,
            onChanged: widget.onDescriptionChanged,
            hintText: 'Enter category description',
          ),
          const SizedBox(height: 20),
          MenuCategoryTextField(
            label: 'Display Order (Optional)',
            controller: _displayOrderController,
            onChanged: (val) {
              final order = int.tryParse(val);
              widget.onDisplayOrderChanged(order);
            },
            keyboardType: TextInputType.number,
            hintText: 'e.g. 1, 2, 3',
          ),
        ],
      ),
    );
  }
}
