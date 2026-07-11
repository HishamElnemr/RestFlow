import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestflowAnimatedLogo extends StatefulWidget {
  final VoidCallback? onAnimationComplete;
  final double width;

  const RestflowAnimatedLogo({
    super.key,
    this.onAnimationComplete,
    this.width = 200.0,
  });

  @override
  State<RestflowAnimatedLogo> createState() => _RestflowAnimatedLogoState();
}

class _RestflowAnimatedLogoState extends State<RestflowAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutBack),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: SvgPicture.asset(
              'assets/images/logo_light.svg',
              width: widget.width,
            ),
          ),
        );
      },
    );
  }
}
