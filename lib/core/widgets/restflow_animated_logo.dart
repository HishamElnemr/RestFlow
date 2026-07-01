import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RestflowAnimatedLogo extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const RestflowAnimatedLogo({
    super.key,
    this.onAnimationComplete,
  });

  @override
  State<RestflowAnimatedLogo> createState() => _RestflowAnimatedLogoState();
}

class _RestflowAnimatedLogoState extends State<RestflowAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _lineWidthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _lineWidthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward().then((_) {
      if (widget.onAnimationComplete != null) {
        widget.onAnimationComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontFamily: 'Poppins',
            ) ??
        const TextStyle(
          fontSize: 36,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'Poppins',
        );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Opacity(
              opacity: _opacityAnimation.value,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'RestFlow',
                  style: textStyle,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 24,
                child: CustomPaint(
                  painter: _CurvePainter(
                    _lineWidthAnimation.value,
                    AppColors.orange,
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

class _CurvePainter extends CustomPainter {
  final double progress;
  final Color color;

  _CurvePainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0) return;

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

    if (progress == 1.0) {
      canvas.drawPath(path, paint);
    } else {
      final metrics = path.computeMetrics().first;
      final extractPath = metrics.extractPath(0.0, metrics.length * progress);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CurvePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
