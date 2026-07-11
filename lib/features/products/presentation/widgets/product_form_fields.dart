import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../menu/domain/entities/menu_category_list_entity.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight),
                image: _selectedImageFile != null
                    ? DecorationImage(
                        image: FileImage(_selectedImageFile!),
                        fit: BoxFit.cover,
                      )
                    : (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(widget.initialImageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: (_selectedImageFile == null && (widget.initialImageUrl == null || widget.initialImageUrl!.isEmpty))
                  ? const Icon(Icons.add_a_photo, color: AppColors.mutedGray, size: 40)
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text('Tap to change image', style: AppStyles.captionRegular12(context).copyWith(color: AppColors.mutedGray)),
        ),
        const SizedBox(height: 24),
        Text('Product Name', style: AppStyles.body1Medium16(context).copyWith(fontWeight: FontWeight.w500, color: AppColors.darkNavy)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _nameController,
          onChanged: widget.onNameChanged,
          decoration: InputDecoration(
            hintText: 'Enter product name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
          validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        Text('Category', style: AppStyles.body1Medium16(context).copyWith(fontWeight: FontWeight.w500, color: AppColors.darkNavy)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedCategoryId,
          items: widget.categories.map((cat) {
            return DropdownMenuItem<String>(
              value: cat.id,
              child: Text(cat.categoryName),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedCategoryId = val;
            });
            widget.onCategoryChanged(val);
          },
          decoration: InputDecoration(
            hintText: 'Select a category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
          validator: (val) => val == null ? 'Please select a category' : null,
        ),
        const SizedBox(height: 16),
        Text('Price', style: AppStyles.body1Medium16(context).copyWith(fontWeight: FontWeight.w500, color: AppColors.darkNavy)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _priceController,
          onChanged: widget.onPriceChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: '0.00',
            prefixText: '\$ ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
          validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Available', style: AppStyles.body1Medium16(context).copyWith(fontWeight: FontWeight.w500, color: AppColors.darkNavy)),
            Switch(
              value: _isAvailable,
              activeThumbColor: AppColors.electricBlue,
              onChanged: (val) {
                setState(() {
                  _isAvailable = val;
                });
                widget.onAvailabilityChanged(val);
              },
            ),
          ],
        ),
      ],
    );
  }
}

