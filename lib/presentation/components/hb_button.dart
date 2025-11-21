import 'package:flutter/material.dart';

enum HBButtonVariant { primary, secondary, outline, ghost }

class HBButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final HBButtonVariant variant;
  final bool loading;

  const HBButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = HBButtonVariant.primary,
    this.loading = false,
  });

  ButtonStyle _style(BuildContext context) {
    final theme = Theme.of(context);
    switch (variant) {
      case HBButtonVariant.primary:
        return FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      case HBButtonVariant.secondary:
        return FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      case HBButtonVariant.outline:
        return OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      case HBButtonVariant.ghost:
        return TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    switch (variant) {
      case HBButtonVariant.primary:
      case HBButtonVariant.secondary:
        return FilledButton(
          onPressed: onPressed,
          style: _style(context),
          child: child,
        );
      case HBButtonVariant.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: _style(context),
          child: child,
        );
      case HBButtonVariant.ghost:
        return TextButton(
          onPressed: onPressed,
          style: _style(context),
          child: child,
        );
    }
  }
}

