import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RestflowLogo extends StatelessWidget {
  const RestflowLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontFamily: 'Poppins',
            ) ??
        const TextStyle(
          fontSize: 36,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'Poppins',
        );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'RestFlow',
            style: textStyle,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: SizedBox(
            height: 24,
            child: CustomPaint(
              painter: _CurvePainter(AppColors.orange),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Color color;

  _CurvePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.65);
    path.cubicTo(
      size.width * 0.5,
      size.height * 0.45,
      size.width * 0.85,
      size.height * 0.45,
      size.width,
      size.height * 0.8,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CurvePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
