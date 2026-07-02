import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../models/menu_product_model.dart';
import '../widgets/menu_category_tabs.dart';
import '../widgets/menu_product_card.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Items (12)',
    'Pizza (5)',
    'Pasta (4)',
    'Salad (3)',
  ];

  final List<MenuProduct> _products = [
    const MenuProduct(
      title: 'Margherita Pizza',
      subtitle: 'Pizza',
      price: '\$12.99',
      status: 'Available',
      imageAsset: null,
    ),
    const MenuProduct(
      title: 'Pepperoni Pizza',
      subtitle: 'Pizza',
      price: '\$14.99',
      status: 'Available',
      imageAsset: null,
    ),
    const MenuProduct(
      title: 'Pasta Carbonara',
      subtitle: 'Pasta',
      price: '\$15.99',
      status: 'Available',
      imageAsset: null,
    ),
    const MenuProduct(
      title: 'Chicken Tikka Masala',
      subtitle: 'Main Course',
      price: '\$16.99',
      status: 'Available',
      imageAsset: null,
    ),
    const MenuProduct(
      title: 'Caesar Salad',
      subtitle: 'Salads',
      price: '\$8.99',
      status: 'Available',
      imageAsset: null,
    ),
    const MenuProduct(
      title: 'Vegetarian Pizza',
      subtitle: 'Pizza',
      price: '\$13.99',
      status: 'Unavailable',
      imageAsset: null,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSearchRow(context),
              const SizedBox(height: 18),
              MenuCategoryTabs(
                categories: _categories,
                selectedIndex: _selectedCategoryIndex,
                onTap: (index) =>
                    setState(() => _selectedCategoryIndex = index),
              ),
              const SizedBox(height: 18),
              Expanded(child: _buildProductsGrid(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Menu',
          style: AppStyles.heading2Bold24(context).copyWith(
            color: AppColors.darkNavy,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: const Text(
            'Demo: Switch to Employee',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: AppStyles.body2Regular14(context)
                  .copyWith(color: AppColors.mutedGray),
              filled: true,
              fillColor: AppColors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_view_rounded),
            color: AppColors.darkNavy,
          ),
        ),
      ],
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
    return GridView.builder(
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final product = _products[index];
        return MenuProductCard(product: product);
      },
    );
  }
}
