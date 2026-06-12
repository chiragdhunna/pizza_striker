import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/pizza_strike_meter.dart';

/// Celebratory overlay shown when a strike pushes a user over the threshold.
Future<void> showPizzaPartyDialog(
  BuildContext context, {
  required String name,
  required int strikeCount,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final colors = context.colors;
      return Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 92, color: colors.primary.withOpacity(0.25)),
                  const Text('🍕', style: TextStyle(fontSize: 56)),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                '$name owes pizza!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$strikeCount strikes reached',
                style: TextStyle(color: colors.textSecondary),
              ),
              const SizedBox(height: 12),
              Text(
                'Pizza Time!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 14),
              PizzaStrikeMeter(current: strikeCount, total: strikeCount, size: 30),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
