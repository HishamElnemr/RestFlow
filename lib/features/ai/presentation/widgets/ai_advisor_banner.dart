import 'package:flutter/material.dart';

class AiAdvisorBanner extends StatelessWidget {
  const AiAdvisorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFAF5FF), // bg-[#faf5ff]
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9D4FF), // border-[#e9d4ff]
            width: 1.18,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: const Text(
        'Read-only advisor — cannot modify restaurant data',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF8200DB), // text-[#8200db]
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
