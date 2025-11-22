import 'package:flutter/material.dart';

// Defines the custom color palette for the application, referenced by AppTheme.
class AppColors {
  // Primary Brand Colors (from Figma designs)
  static const Color primaryBlurple = Color(0xFF5865F2); // Main brand color
  static const Color darkNavy = Color(0xFF1A1F36); // Headlines and primary text
  static const Color slateGrey = Color(0xFF697386); // Secondary text and subtitles
  
  // Accent Colors (from Figma)
  static const Color accentOrange = Color(0xFFFF9800); // Creator accents, CTAs
  static const Color accentGreen = Color(0xFF4CAF50); // Success, affiliate
  static const Color accentRed = Color(0xFFE57373); // Error, warnings
  
  // Background Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA); // Very subtle background
  static const Color lightBackground = Color(0xFFF4F4F9);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE5E7EB); // Subtle borders
  
  // Text Colors
  static const Color darkText = Color(0xFF1A1F36); // Updated to match navy
  static const Color mediumText = Color(0xFF697386); // Updated to match slate
  static const Color lightText = Color(0xFF9CA3AF); // Disabled/hints
  static const Color whiteText = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Shadow & Elevation
  static const Color shadowLight = Color(0x0A000000); // Subtle shadows
  static const Color shadowMedium = Color(0x14000000); // Cards
  static const Color shadowStrong = Color(0x1F000000); // Elevated elements
  
  // Legacy Colors (for dark theme/roles)
  static const Color primaryBlue = Color(0xFF1A73E8);
  static const Color darkGray = Color(0xFF121212);
  static const Color warmBeige = Color(0xFFF5F5DC);
  static const Color sandStone = Color(0xFFC2B280);
  static const Color oliveBrown = Color(0xFF808000);
  static const Color clayNude = Color(0xFFB0988A);
  static const Color sageGreen = Color(0xFF8FBC8F);
  static const Color textSecondary = Color(0xFF424242);
  static const Color dividerBorder = Color(0xFF616161);
}
