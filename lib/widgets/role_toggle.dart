import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A two-segment Admin / Employee pill toggle, as in the login & register mockups.
class RoleToggle extends StatelessWidget {
  const RoleToggle({super.key, required this.value, required this.onChanged});

  /// 'admin' or 'employee'.
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.fieldFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.fieldBorder),
      ),
      child: Row(
        children: [
          _segment(context, 'admin', 'Admin'),
          _segment(context, 'employee', 'Employee'),
        ],
      ),
    );
  }

  Widget _segment(BuildContext context, String key, String label) {
    final colors = context.colors;
    final selected = value == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? colors.onPrimary : colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
