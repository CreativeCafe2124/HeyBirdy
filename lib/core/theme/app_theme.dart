import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData _base(ColorScheme scheme) {
    final textTheme = TextTheme(
      // Display/Headlines: Inter (adjusted for modern look)
      displayLarge: GoogleFonts.inter(
          fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.darkText),
      displayMedium: GoogleFonts.inter(
          fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkText),
      displaySmall: GoogleFonts.inter(
          fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.darkText),
      headlineLarge: GoogleFonts.inter(
          fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headlineMedium: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkText),
      headlineSmall: GoogleFonts.inter(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText),
      // Body/Title: Inter
      titleLarge: GoogleFonts.inter(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText),
      titleMedium: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.darkText),
      titleSmall: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText),
      bodyLarge: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.darkText),
      bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.mediumText),
      bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.mediumText),
      labelLarge: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkText),
      labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.mediumText),
      labelSmall: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText),
    ).apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.brightness == Brightness.dark
          ? AppColors.darkGray
          : AppColors.lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.secondaryContainer,
        contentTextStyle: TextStyle(color: scheme.onSecondaryContainer),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        shadowColor: scheme.shadow.withValues(alpha: 0.3),
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 2,
        ),
      ),
    );
  }

  static final ThemeData light = _base(
    ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.darkText,
      primaryContainer: AppColors.primaryBlue,
      onPrimaryContainer: AppColors.white,
      secondary: AppColors.accentOrange,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.accentOrange.withValues(alpha: 0.1),
      onSecondaryContainer: AppColors.accentOrange,
      tertiary: AppColors.primaryBlue,
      onTertiary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.cardBackground,
      onSurface: AppColors.darkText,
      surfaceContainerHighest: AppColors.borderColor,
      onSurfaceVariant: AppColors.mediumText,
      outline: AppColors.borderColor,
      shadow: Colors.black12,
    ),
  );

  static final ThemeData dark = _base(
    ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.warmBeige,
      onPrimary: AppColors.darkGray,
      primaryContainer: AppColors.sandStone,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.oliveBrown,
      onSecondary: AppColors.clayNude,
      secondaryContainer: AppColors.sageGreen.withValues(alpha: 0.2),
      onSecondaryContainer: AppColors.oliveBrown,
      tertiary: Colors.orange.shade700, // Terracotta dark variant
      onTertiary: AppColors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.darkGray,
      onSurface: AppColors.white,
      surfaceContainerHighest: AppColors.textSecondary,
      onSurfaceVariant: AppColors.mediumText.withValues(alpha: 0.8), // Figma: secondary surface text
      outline: AppColors.dividerBorder.withValues(alpha: 0.6), // Figma: subtle borders
      shadow: Colors.black.withValues(alpha: 0.15), // Figma: elevated shadows
    ),
  );
}
