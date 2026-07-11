import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import 'customer_text_field.dart';

class CustomerFormFields extends StatefulWidget {
  const CustomerFormFields({
    super.key,
    required this.initialFullName,
    required this.initialPhoneNumber,
    required this.initialIsActive,
    required this.onFullNameChanged,
    required this.onPhoneNumberChanged,
    required this.onIsActiveChanged,
  });

  final String initialFullName;
  final String initialPhoneNumber;
  final bool initialIsActive;
  final ValueChanged<String> onFullNameChanged;
  final ValueChanged<String> onPhoneNumberChanged;
  final ValueChanged<bool> onIsActiveChanged;

  @override
  State<CustomerFormFields> createState() => _CustomerFormFieldsState();
}

class _CustomerFormFieldsState extends State<CustomerFormFields> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.initialFullName);
    _phoneNumberController = TextEditingController(text: widget.initialPhoneNumber);
    _isActive = widget.initialIsActive;
  }

  @override
  void didUpdateWidget(covariant CustomerFormFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFullName != widget.initialFullName ||
        oldWidget.initialPhoneNumber != widget.initialPhoneNumber ||
        oldWidget.initialIsActive != widget.initialIsActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (oldWidget.initialFullName != widget.initialFullName) {
          _fullNameController.text = widget.initialFullName;
        }
        if (oldWidget.initialPhoneNumber != widget.initialPhoneNumber) {
          _phoneNumberController.text = widget.initialPhoneNumber;
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
    _phoneNumberController.dispose();
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
          CustomerTextField(
            label: 'Full Name',
            controller: _fullNameController,
            onChanged: widget.onFullNameChanged,
            hintText: 'e.g. John Doe',
            validator: (val) =>
                (val == null || val.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          CustomerTextField(
            label: 'Phone Number',
            controller: _phoneNumberController,
            onChanged: widget.onPhoneNumberChanged,
            hintText: 'e.g. +1234567890',
            keyboardType: TextInputType.phone,
            validator: (val) =>
                (val == null || val.isEmpty) ? 'Required' : null,
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
