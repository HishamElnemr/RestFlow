import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'employee_text_field.dart';

class EmployeeFormFields extends StatefulWidget {
  const EmployeeFormFields({
    super.key,
    required this.initialFullName,
    required this.initialEmail,
    required this.initialPhoneNumber,
    required this.initialRole,
    required this.initialIsActive,
    this.initialPassword,
    required this.onFullNameChanged,
    required this.onEmailChanged,
    required this.onPhoneNumberChanged,
    required this.onRoleChanged,
    required this.onIsActiveChanged,
    this.onPasswordChanged,
    this.isEditing = false,
  });

  final String initialFullName;
  final String initialEmail;
  final String initialPhoneNumber;
  final String initialRole;
  final bool initialIsActive;
  final String? initialPassword;
  final ValueChanged<String> onFullNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneNumberChanged;
  final ValueChanged<String> onRoleChanged;
  final ValueChanged<bool> onIsActiveChanged;
  final ValueChanged<String>? onPasswordChanged;
  final bool isEditing;

  @override
  State<EmployeeFormFields> createState() => _EmployeeFormFieldsState();
}

class _EmployeeFormFieldsState extends State<EmployeeFormFields> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late String _role;
  late bool _isActive;

  final List<String> _roles = ['Owner', 'Manager', 'Cashier', 'Chef'];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.initialFullName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneNumberController = TextEditingController(text: widget.initialPhoneNumber);
    _passwordController = TextEditingController(text: widget.initialPassword ?? '');
    _role = widget.initialRole.isNotEmpty ? widget.initialRole : _roles.first;
    _isActive = widget.initialIsActive;
  }

  @override
  void didUpdateWidget(covariant EmployeeFormFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFullName != widget.initialFullName ||
        oldWidget.initialEmail != widget.initialEmail ||
        oldWidget.initialPhoneNumber != widget.initialPhoneNumber ||
        oldWidget.initialRole != widget.initialRole ||
        oldWidget.initialIsActive != widget.initialIsActive ||
        oldWidget.initialPassword != widget.initialPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (oldWidget.initialFullName != widget.initialFullName) {
          _fullNameController.text = widget.initialFullName;
        }
        if (oldWidget.initialEmail != widget.initialEmail) {
          _emailController.text = widget.initialEmail;
        }
        if (oldWidget.initialPhoneNumber != widget.initialPhoneNumber) {
          _phoneNumberController.text = widget.initialPhoneNumber;
        }
        if (oldWidget.initialPassword != widget.initialPassword) {
          _passwordController.text = widget.initialPassword ?? '';
        }
        if (oldWidget.initialRole != widget.initialRole) {
          setState(() {
            _role = widget.initialRole.isNotEmpty ? widget.initialRole : _roles.first;
          });
        }
        if (oldWidget.initialIsActive != widget.initialIsActive) {
          setState(() {
            _isActive = widget.initialIsActive;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
          EmployeeTextField(
            label: 'Full Name',
            controller: _fullNameController,
            onChanged: widget.onFullNameChanged,
            hintText: 'e.g. John Doe',
            validator: (val) =>
                (val == null || val.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          EmployeeTextField(
            label: 'Email',
            controller: _emailController,
            onChanged: widget.onEmailChanged,
            hintText: 'e.g. john@example.com',
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Required';
              if (!val.contains('@')) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 20),
          EmployeeTextField(
            label: 'Phone Number',
            controller: _phoneNumberController,
            onChanged: widget.onPhoneNumberChanged,
            hintText: 'e.g. +1234567890',
            keyboardType: TextInputType.phone,
            validator: (val) =>
                (val == null || val.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          if (!widget.isEditing) ...[
            EmployeeTextField(
              label: 'Password',
              controller: _passwordController,
              onChanged: widget.onPasswordChanged ?? (_) {},
              hintText: 'Minimum 6 characters',
              obscureText: true,
              validator: (val) =>
                  (val == null || val.isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 20),
          ],
          Text(
            'Role',
            style: AppStyles.body2Medium14(context).copyWith(
              color: AppColors.darkNavy,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _role,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.mutedGray),
                dropdownColor: Colors.white,
                style: AppStyles.body2Regular14(context)
                    .copyWith(color: AppColors.darkNavy),
                items: _roles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _role = val;
                    });
                    widget.onRoleChanged(val);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Status',
                style: AppStyles.body2Medium14(context).copyWith(
                  color: AppColors.darkNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: _isActive,
                onChanged: (val) {
                  setState(() {
                    _isActive = val;
                  });
                  widget.onIsActiveChanged(val);
                },
                activeThumbColor: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
