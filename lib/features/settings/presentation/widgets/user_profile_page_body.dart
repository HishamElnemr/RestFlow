import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/dummy_data/dummy_user_profile.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../domain/entities/update_profile_request_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../cubit/user_profile_settings/user_profile_settings_cubit.dart';
import '../cubit/user_profile_settings/user_profile_settings_state.dart';
import 'user_profile_form.dart';
import 'user_profile_header.dart';
import 'user_profile_save_button.dart';

class UserProfilePageBody extends StatefulWidget {
  const UserProfilePageBody({super.key});

  @override
  State<UserProfilePageBody> createState() => _UserProfilePageBodyState();
}

class _UserProfilePageBodyState extends State<UserProfilePageBody> {
  bool _isEditing = false;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _languageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _languageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  void _populateFields(UserProfileEntity profile) {
    if (_nameController.text.isEmpty && !_isEditing) {
      _nameController.text = profile.fullName;
      _emailController.text = profile.email;
      _phoneController.text = profile.phoneNumber;
      _languageController.text = profile.preferredLanguage;
    }
  }

  void _saveProfile() {
    final updateRequest = UpdateProfileRequestEntity(
      fullName: _nameController.text,
      preferredLanguage: _languageController.text,
    );
    context.read<UserProfileSettingsCubit>().updateUserProfile(updateRequest);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileSettingsCubit, UserProfileSettingsState>(
      listener: (context, state) {
        if (state is UserProfileSettingsUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: AppColors.successBright,
            ),
          );
          setState(() {
            _isEditing = false;
          });
          context.read<UserProfileSettingsCubit>().fetchUserProfile();
        } else if (state is UserProfileSettingsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is UserProfileSettingsLoading ||
            state is UserProfileSettingsInitial;

        var displayProfile = dummyUserProfile;
        if (state is UserProfileSettingsLoaded) {
          displayProfile = state.profile;
          _populateFields(displayProfile);
        }

        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: 'Profile',
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
                      UserProfileHeader(
                        imageUrl: displayProfile.profileImageUrl,
                        name: displayProfile.fullName,
                        isEditing: _isEditing,
                        onEditToggled: () {
                          setState(() {
                            _isEditing = !_isEditing;
                            if (!_isEditing) {
                              _nameController.text = displayProfile.fullName;
                              _emailController.text = displayProfile.email;
                              _phoneController.text =
                                  displayProfile.phoneNumber;
                              _languageController.text =
                                  displayProfile.preferredLanguage;
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
                          border: Border.all(
                              color: AppColors.warmGray, width: 1.18),
                        ),
                        child: UserProfileForm(
                          isEditing: _isEditing,
                          nameController: _nameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          languageController: _languageController,
                        ),
                      ),
                      if (_isEditing) ...[
                        const SizedBox(height: 32),
                        UserProfileSaveButton(
                          isLoading: isLoading,
                          onPressed: _saveProfile,
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
