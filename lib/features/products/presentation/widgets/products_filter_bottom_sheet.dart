import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

typedef ProductsFilterApplyCallback = void Function(
  bool? isAvailable,
  double? minPrice,
  double? maxPrice,
);

class ProductsFilterBottomSheet extends StatefulWidget {
  const ProductsFilterBottomSheet({
    super.key,
    required this.selectedIsAvailable,
    required this.minPrice,
    required this.maxPrice,
    required this.onApply,
  });

  final bool? selectedIsAvailable;
  final double? minPrice;
  final double? maxPrice;
  final ProductsFilterApplyCallback onApply;

  @override
  State<ProductsFilterBottomSheet> createState() =>
      _ProductsFilterBottomSheetState();
}

class _ProductsFilterBottomSheetState extends State<ProductsFilterBottomSheet> {
  bool? _isAvailable;
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isAvailable = widget.selectedIsAvailable;
    if (widget.minPrice != null) {
      _minPriceController.text = widget.minPrice.toString();
    }
    if (widget.maxPrice != null) {
      _maxPriceController.text = widget.maxPrice.toString();
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _apply() {
    final minPrice = double.tryParse(_minPriceController.text);
    final maxPrice = double.tryParse(_maxPriceController.text);
    widget.onApply(_isAvailable, minPrice, maxPrice);
    Navigator.of(context).pop();
  }

  void _clearAll() {
    setState(() {
      _isAvailable = null;
      _minPriceController.clear();
      _maxPriceController.clear();
    });
    widget.onApply(null, null, null);
    Navigator.of(context).pop();
  }

  bool get _hasAny =>
      _isAvailable != null ||
      _minPriceController.text.isNotEmpty ||
      _maxPriceController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.warmGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'More Filters',
                    style: AppStyles.heading3SemiBold18(context).copyWith(
                      color: AppColors.darkNavy,
                    ),
                  ),
                  const Spacer(),
                  if (_hasAny)
                    GestureDetector(
                      onTap: _clearAll,
                      child: Text(
                        'Clear all',
                        style: AppStyles.body2Medium14(context).copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Availability',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _FilterOption(
              label: 'Available',
              isSelected: _isAvailable == true,
              onTap: () => setState(() {
                _isAvailable = _isAvailable == true ? null : true;
              }),
            ),
            _FilterOption(
              label: 'Unavailable',
              isSelected: _isAvailable == false,
              onTap: () => setState(() {
                _isAvailable = _isAvailable == false ? null : false;
              }),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Price Range',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.mutedGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Min',
                        hintStyle: AppStyles.body2Medium14(context).copyWith(color: AppColors.mutedGray),
                        filled: true,
                        fillColor: AppColors.surfaceLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '-',
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.darkNavy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Max',
                        hintStyle: AppStyles.body2Medium14(context).copyWith(color: AppColors.mutedGray),
                        filled: true,
                        fillColor: AppColors.surfaceLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.borderLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _apply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Apply Filters',
                    style: AppStyles.body2Medium14(context).copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              label,
              style: AppStyles.body2Medium14(context).copyWith(
                color: isSelected ? AppColors.primary : AppColors.darkNavy,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.warmGray,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 13)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
