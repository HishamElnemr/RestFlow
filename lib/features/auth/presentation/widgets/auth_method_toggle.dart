import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum AuthMethod { email, phone }

/// Reusable tab toggle for switching between Email and Phone login methods
///
/// Features a grey background container with a sliding white active tab effect.
class AuthMethodToggle extends StatelessWidget {
  final AuthMethod currentMethod;
  final ValueChanged<AuthMethod> onChanged;

  const AuthMethodToggle({
    super.key,
    required this.currentMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context,
              method: AuthMethod.email,
              icon: Icons.email_outlined,
              label: 'Email',
            ),
          ),
          Expanded(
            child: _buildTab(
              context,
              method: AuthMethod.phone,
              icon: Icons.phone_outlined,
              label: 'Phone',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required AuthMethod method,
    required IconData icon,
    required String label,
  }) {
    final isActive = currentMethod == method;
    return GestureDetector(
      onTap: () => onChanged(method),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive
              ? Border.all(color: AppColors.borderLight)
              : Border.all(color: Colors.transparent),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? AppColors.primary : AppColors.mutedGray,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.mutedGray,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
