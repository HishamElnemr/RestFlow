import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../menu/domain/entities/menu_category_list_entity.dart';
import 'product_availability_switch.dart';
import 'product_category_dropdown.dart';
import 'product_image_picker.dart';
import 'product_text_field.dart';

class ProductFormFields extends StatefulWidget {
  const ProductFormFields({
    super.key,
    required this.initialName,
    required this.initialPrice,
    required this.initialIsAvailable,
    required this.categories,
    this.initialCategoryId,
    this.initialImageUrl,
    required this.onNameChanged,
    required this.onPriceChanged,
    required this.onAvailabilityChanged,
    required this.onCategoryChanged,
    required this.onImageChanged,
  });

  final String initialName;
  final double initialPrice;
  final bool initialIsAvailable;
  final List<MenuCategoryListEntity> categories;
  final String? initialCategoryId;
  final String? initialImageUrl;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onPriceChanged;
  final ValueChanged<bool> onAvailabilityChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onImageChanged;

  @override
  State<ProductFormFields> createState() => _ProductFormFieldsState();
}

class _ProductFormFieldsState extends State<ProductFormFields> {
  late bool _isAvailable;
  String? _selectedCategoryId;
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _isAvailable = widget.initialIsAvailable;
    _selectedCategoryId = widget.initialCategoryId;
    _nameController = TextEditingController(text: widget.initialName);
    _priceController = TextEditingController(
      text: widget.initialPrice > 0 ? widget.initialPrice.toString() : '',
    );
  }

  @override
  void didUpdateWidget(covariant ProductFormFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialName != widget.initialName ||
        oldWidget.initialPrice != widget.initialPrice ||
        oldWidget.initialIsAvailable != widget.initialIsAvailable ||
        oldWidget.initialCategoryId != widget.initialCategoryId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (oldWidget.initialName != widget.initialName) {
          _nameController.text = widget.initialName;
        }
        if (oldWidget.initialPrice != widget.initialPrice) {
          _priceController.text =
              widget.initialPrice > 0 ? widget.initialPrice.toString() : '';
        }
        setState(() {
          if (oldWidget.initialIsAvailable != widget.initialIsAvailable) {
            _isAvailable = widget.initialIsAvailable;
          }
          if (oldWidget.initialCategoryId != widget.initialCategoryId) {
            _selectedCategoryId = widget.initialCategoryId;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final bytes = await imageFile.readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _selectedImageFile = imageFile;
        });
        widget.onImageChanged(base64String);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
              ProductImagePicker(
                onTap: _pickImage,
                selectedImageFile: _selectedImageFile,
                initialImageUrl: widget.initialImageUrl,
              ),
              const SizedBox(height: 32),
              ProductTextField(
                label: 'Product Name',
                controller: _nameController,
                onChanged: widget.onNameChanged,
                hintText: 'Enter product name',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ProductCategoryDropdown(
                categories: widget.categories,
                selectedCategoryId: _selectedCategoryId,
                onChanged: (val) {
                  setState(() => _selectedCategoryId = val);
                  widget.onCategoryChanged(val);
                },
              ),
              const SizedBox(height: 20),
              ProductTextField(
                label: 'Price',
                controller: _priceController,
                onChanged: widget.onPriceChanged,
                hintText: '0.00',
                prefixText: '\$ ',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              ProductAvailabilitySwitch(
                isAvailable: _isAvailable,
                onChanged: (val) {
                  setState(() => _isAvailable = val);
                  widget.onAvailabilityChanged(val);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
