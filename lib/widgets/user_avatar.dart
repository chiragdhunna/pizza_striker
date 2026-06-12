import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A circular avatar showing the user's initials over a tinted background.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initials,
    this.radius = 22,
    this.highlighted = false,
  });

  final String initials;
  final double radius;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return CircleAvatar(
      radius: radius,
      backgroundColor: highlighted
          ? colors.primary
          : colors.primary.withOpacity(0.15),
      child: Text(
        initials,
        style: TextStyle(
          color: highlighted ? colors.onPrimary : colors.primary,
          fontWeight: FontWeight.w700,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }
}
