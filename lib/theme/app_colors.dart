import 'package:flutter/material.dart';

/// Semantic colors for the Pizza Striker UI, exposed as a [ThemeExtension] so
/// widgets can read `Theme.of(context).extension<AppColors>()!` and stay
/// correct in both light and dark mode.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.primary,
    required this.onPrimary,
    required this.danger,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.fieldFill,
    required this.fieldBorder,
    required this.owesBannerBg,
    required this.owesBannerText,
    required this.warningBg,
    required this.warningText,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color primary;
  final Color onPrimary;
  final Color danger;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color fieldFill;
  final Color fieldBorder;
  final Color owesBannerBg;
  final Color owesBannerText;
  final Color warningBg;
  final Color warningText;

  static const AppColors light = AppColors(
    background: Color(0xFFFBF5EA),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFFFFDF8),
    primary: Color(0xFFEF6C1A),
    onPrimary: Color(0xFFFFFFFF),
    danger: Color(0xFFED4D2D),
    textPrimary: Color(0xFF1E2430),
    textSecondary: Color(0xFF6B7280),
    divider: Color(0xFFECE7DC),
    fieldFill: Color(0xFFFFFFFF),
    fieldBorder: Color(0xFFE6E1D5),
    owesBannerBg: Color(0xFFC56B2C),
    owesBannerText: Color(0xFFFFFFFF),
    warningBg: Color(0xFFFCE9E0),
    warningText: Color(0xFFC0531F),
  );

  static const AppColors dark = AppColors(
    background: Color(0xFF0E0F13),
    surface: Color(0xFF1A1B21),
    surfaceAlt: Color(0xFF15161B),
    primary: Color(0xFFF2741A),
    onPrimary: Color(0xFFFFFFFF),
    danger: Color(0xFFE5482A),
    textPrimary: Color(0xFFF4F4F6),
    textSecondary: Color(0xFF9AA0AA),
    divider: Color(0xFF2A2C33),
    fieldFill: Color(0xFF1F2128),
    fieldBorder: Color(0xFF2E3139),
    owesBannerBg: Color(0xFF7A3F18),
    owesBannerText: Color(0xFFFFF3EA),
    warningBg: Color(0xFF3A201B),
    warningText: Color(0xFFF08A5D),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? primary,
    Color? onPrimary,
    Color? danger,
    Color? textPrimary,
    Color? textSecondary,
    Color? divider,
    Color? fieldFill,
    Color? fieldBorder,
    Color? owesBannerBg,
    Color? owesBannerText,
    Color? warningBg,
    Color? warningText,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      danger: danger ?? this.danger,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
      fieldFill: fieldFill ?? this.fieldFill,
      fieldBorder: fieldBorder ?? this.fieldBorder,
      owesBannerBg: owesBannerBg ?? this.owesBannerBg,
      owesBannerText: owesBannerText ?? this.owesBannerText,
      warningBg: warningBg ?? this.warningBg,
      warningText: warningText ?? this.warningText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      fieldFill: Color.lerp(fieldFill, other.fieldFill, t)!,
      fieldBorder: Color.lerp(fieldBorder, other.fieldBorder, t)!,
      owesBannerBg: Color.lerp(owesBannerBg, other.owesBannerBg, t)!,
      owesBannerText: Color.lerp(owesBannerText, other.owesBannerText, t)!,
      warningBg: Color.lerp(warningBg, other.warningBg, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
    );
  }
}

/// Convenience accessor: `context.colors`.
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
