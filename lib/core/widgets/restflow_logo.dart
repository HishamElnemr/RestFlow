import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestflowLogo extends StatelessWidget {
  final double width;

  const RestflowLogo({
    super.key,
    this.width = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo2.svg',
      width: width,
    );
  }
}
