import 'package:flutter/material.dart';

import '../config/app_config.dart';

/// Renders the strike progress as pizza slices — filled slices show how close
/// the user is to owing a pizza party.
class PizzaStrikeMeter extends StatelessWidget {
  const PizzaStrikeMeter({
    super.key,
    required this.current,
    this.total = AppConfig.strikeThreshold,
    this.size = 26,
    this.spacing = 6,
  });

  final int current;
  final int total;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final slots = total <= 0 ? AppConfig.strikeThreshold : total;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(slots, (i) {
        final filled = i < current;
        return Padding(
          padding: EdgeInsets.only(right: i == slots - 1 ? 0 : spacing),
          child: Opacity(
            opacity: filled ? 1.0 : 0.22,
            child: Text('🍕', style: TextStyle(fontSize: size)),
          ),
        );
      }),
    );
  }
}
