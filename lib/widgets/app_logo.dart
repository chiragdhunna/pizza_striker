import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The Pizza Striker logo, swapping asset by brightness with an icon fallback.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final asset = isDark
        ? 'assets/pizza_striker_logo_dark.png'
        : 'assets/pizza_striker_logo_light.png';
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stack) => Icon(
        Icons.local_pizza_rounded,
        size: size,
        color: context.colors.primary,
      ),
    );
  }
}
