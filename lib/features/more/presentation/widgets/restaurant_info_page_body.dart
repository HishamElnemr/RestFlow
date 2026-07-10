import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_restaurant_settings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../settings/domain/entities/restaurant_settings_entity.dart';
import '../../settings/domain/entities/update_restaurant_settings_request_entity.dart';
import '../../settings/presentation/cubit/restaurant_settings/restaurant_settings_cubit.dart';
import '../../settings/presentation/cubit/restaurant_settings/restaurant_settings_state.dart';
import 'restaurant_info_form.dart';
import 'restaurant_info_header.dart';
import 'restaurant_info_save_button.dart';

class RestaurantInfoPageBody extends StatefulWidget {
  const RestaurantInfoPageBody({super.key});

  @override
  State<RestaurantInfoPageBody> createState() => _RestaurantInfoPageBodyState();
}

class _RestaurantInfoPageBodyState extends State<RestaurantInfoPageBody> {
  bool _isEditing = false;
  
  late final TextEditingController _nameController;
  late final TextEditingController _cuisineController;
  late final TextEditingController _countryController;
  late final TextEditingController _languageController;
  late final TextEditingController _timezoneController;
  late final TextEditingController _currencyController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cuisineController = TextEditingController();
    _countryController = TextEditingController();
    _languageController = TextEditingController();
    _timezoneController = TextEditingController();
    _currencyController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cuisineController.dispose();
    _countryController.dispose();
    _languageController.dispose();
    _timezoneController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _populateFields(RestaurantSettingsEntity settings) {
    if (_nameController.text.isEmpty && !_isEditing) {
      _nameController.text = settings.restaurantName;
      _cuisineController.text = settings.cuisineType ?? '';
      _countryController.text = settings.country;
      _languageController.text = settings.defaultLanguage;
      _timezoneController.text = settings.timezone;
      _currencyController.text = settings.currency;
    }
  }

  void _saveSettings() {
    final updateRequest = UpdateRestaurantSettingsRequestEntity(
      restaurantName: _nameController.text,
      cuisineType: _cuisineController.text.isNotEmpty ? _cuisineController.text : null,
      country: _countryController.text,
      defaultLanguage: _languageController.text,
      timezone: _timezoneController.text,
      currency: _currencyController.text,
    );
    context.read<RestaurantSettingsCubit>().updateRestaurantSettings(updateRequest);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantSettingsCubit, RestaurantSettingsState>(
      listener: (context, state) {
        if (state is RestaurantSettingsUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings updated successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          setState(() {
            _isEditing = false;
          });
          context.read<RestaurantSettingsCubit>().fetchRestaurantSettings();
        } else if (state is RestaurantSettingsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is RestaurantSettingsLoading ||
            state is RestaurantSettingsInitial;
            
        var displaySettings = dummyRestaurantSettings;
        if (state is RestaurantSettingsLoaded) {
          displaySettings = state.settings;
          _populateFields(displaySettings);
        }

        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: 'Restaurant Details',
              showBackButton: true,
            ),
            Skeletonizer.sliver(
              enabled: isLoading,
              containersColor: Colors.grey.shade100,
              ignoreContainers: false,
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade50,
              ),
              child: SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RestaurantInfoHeader(
                        logoUrl: displaySettings.restaurantLogoUrl,
                        name: displaySettings.restaurantName,
                        isEditing: _isEditing,
                        onEditToggled: () {
                          setState(() {
                            _isEditing = !_isEditing;
                            if (!_isEditing) {
                              _nameController.text = displaySettings.restaurantName;
                              _cuisineController.text = displaySettings.cuisineType ?? '';
                              _countryController.text = displaySettings.country;
                              _languageController.text = displaySettings.defaultLanguage;
                              _timezoneController.text = displaySettings.timezone;
                              _currencyController.text = displaySettings.currency;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.warmGray, width: 1.18),
                        ),
                        child: RestaurantInfoForm(
                          isEditing: _isEditing,
                          nameController: _nameController,
                          cuisineController: _cuisineController,
                          countryController: _countryController,
                          languageController: _languageController,
                          timezoneController: _timezoneController,
                          currencyController: _currencyController,
                        ),
                      ),
                      if (_isEditing) ...[
                        const SizedBox(height: 32),
                        RestaurantInfoSaveButton(
                          isLoading: isLoading,
                          onPressed: _saveSettings,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
