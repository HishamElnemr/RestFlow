import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AiChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const AiChatBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) const SizedBox(width: 16),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : AppColors.white,
                border: isUser
                    ? null
                    : Border.all(
                        color: AppColors.warmGray,
                        width: 1.18,
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 8),
                  bottomRight: Radius.circular(isUser ? 8 : 16),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? AppColors.white : AppColors.darkNavy,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 16),
        ],
      ),
    );
  }
}
