import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import local files immediately after package imports
import '../constants/colors.dart';
import 'app_theme.dart';

// --- PLACEHOLDERS FOR DEMO PURPOSES ---
// In a real app, these would come from your state_management.dart
enum AppRole { guest, learner, creator, affiliate, moderator, admin }

final roleProvider = StateProvider<AppRole?>((ref) => AppRole.learner);
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
// ----------------------------------------

/// Determines the primary accent color based on the user's role.
Color _getRoleAccent(AppRole? role) {
  switch (role) {
    case AppRole.guest:
      return Colors.grey[600]!;
    case AppRole.learner:
      return AppColors.primaryBlurple; // Updated to use brand color
    case AppRole.creator:
      return AppColors.accentOrange; // Orange for creators
    case AppRole.affiliate:
      return AppColors.sageGreen; // Green for affiliates
    case AppRole.moderator:
      return AppColors.sandStone;
    case AppRole.admin:
      return AppColors.sandStone;
    default:
      return AppColors.primaryBlurple;
  }
}

/// A Riverpod Provider that exposes the current user's accent color.
final roleAccentProvider = Provider<Color>((ref) {
  final role = ref.watch(roleProvider);
  return _getRoleAccent(role);
});

/// A Riverpod Provider that exposes the full application theme, with the
/// primary and secondary colors overridden by the role-based accent color.
final roleThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  final baseTheme =
      themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;
  final accent = ref.watch(roleAccentProvider);

  // Create a new ColorScheme, overriding primary/secondary with the role accent.
  final scheme = baseTheme.colorScheme.copyWith(
    primary: accent,
    secondary: accent.withValues(alpha: 0.8),
  );

  // Return the base theme with the new, role-specific ColorScheme.
  return baseTheme.copyWith(colorScheme: scheme);
});
