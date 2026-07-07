import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AiInputArea extends StatefulWidget {
  final ValueChanged<String> onSend;
  final bool isLoading;

  const AiInputArea({
    super.key,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<AiInputArea> createState() => _AiInputAreaState();
}

class _AiInputAreaState extends State<AiInputArea> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.isLoading) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.warmGray,
            width: 1.18,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 17.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.warmGray,
                    width: 1.18,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !widget.isLoading,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                  style: const TextStyle(
                    color: AppColors.darkNavy,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ask a question...',
                    hintStyle: TextStyle(
                      color: AppColors.darkNavy.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _handleSend,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: widget.isLoading
                      ? AppColors.primary.withOpacity(0.5)
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: widget.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: AppColors.white,
                          size: 20,
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
