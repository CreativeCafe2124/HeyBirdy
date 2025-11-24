import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData _base(ColorScheme scheme) {
    final textTheme = TextTheme(
      // Display/Headlines: Roboto (matching Figma designs)
      displayLarge: GoogleFonts.roboto(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          color: AppColors.darkNavy,
          height: 1.2,
          letterSpacing: -0.5),
      displayMedium: GoogleFonts.roboto(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: AppColors.darkNavy,
          letterSpacing: -0.5),
      displaySmall: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: AppColors.darkNavy,
          letterSpacing: -0.5),
      headlineLarge: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
          letterSpacing: -0.5),
      headlineMedium: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
          letterSpacing: -0.5),
      headlineSmall: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
          letterSpacing: -0.5),
      // Body/Title: Roboto
      titleLarge: GoogleFonts.roboto(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkNavy),
      titleMedium: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.darkNavy),
      titleSmall: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkNavy),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.darkNavy,
          height: 1.5),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.slateGrey,
          height: 1.5),
      bodySmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.slateGrey,
          height: 1.5),
      labelLarge: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteText),
      labelMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryBlurple),
      labelSmall: GoogleFonts.roboto(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.slateGrey),
    ).apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkNavy,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkNavy,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.secondaryContainer,
        contentTextStyle: TextStyle(color: scheme.onSecondaryContainer),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primaryBlurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.slateGrey,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        shadowColor: AppColors.shadowMedium,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlurple,
          foregroundColor: AppColors.whiteText,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
          shadowColor: AppColors.primaryBlurple.withValues(alpha: 0.4),
          textStyle: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteText,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlurple,
          side: const BorderSide(color: AppColors.primaryBlurple),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryBlurple,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlurple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlurple,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        elevation: 3,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.primaryBlurple.withValues(alpha: 0.1),
      ),
    );
  }

  static final ThemeData light = _base(
    ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryBlurple,
      onPrimary: AppColors.whiteText,
      primaryContainer: AppColors.primaryBlurple,
      onPrimaryContainer: AppColors.whiteText,
      secondary: AppColors.primaryBlurple.withValues(alpha: 0.8),
      onSecondary: AppColors.whiteText,
      secondaryContainer: AppColors.primaryBlurple.withValues(alpha: 0.1),
      onSecondaryContainer: AppColors.primaryBlurple,
      tertiary: AppColors.accentOrange,
      onTertiary: AppColors.whiteText,
      error: AppColors.error,
      onError: AppColors.whiteText,
      surface: AppColors.white,
      onSurface: AppColors.darkNavy,
      surfaceContainerHighest: AppColors.borderColor,
      onSurfaceVariant: AppColors.slateGrey,
      outline: AppColors.borderColor,
      shadow: AppColors.shadowLight,
    ),
  );

  static final ThemeData dark = _base(
    ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryBlurple,
      onPrimary: AppColors.whiteText,
      primaryContainer: AppColors.primaryBlurple,
      onPrimaryContainer: AppColors.whiteText,
      secondary: AppColors.primaryBlurple.withValues(alpha: 0.8),
      onSecondary: AppColors.whiteText,
      secondaryContainer: AppColors.primaryBlurple.withValues(alpha: 0.1),
      onSecondaryContainer: AppColors.primaryBlurple,
      tertiary: AppColors.accentOrange,
      onTertiary: AppColors.whiteText,
      error: AppColors.error,
      onError: AppColors.whiteText,
      surface: AppColors.darkNavy, // Dark background for dark mode
      onSurface: AppColors.whiteText,
      surfaceContainerHighest: AppColors.slateGrey,
      onSurfaceVariant: AppColors.lightText,
      outline: AppColors.borderColor,
      shadow:
          AppColors.shadowLight, // Using existing shadowLight for consistency
    ),
  );
}
