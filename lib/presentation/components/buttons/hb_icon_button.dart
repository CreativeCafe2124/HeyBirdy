import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

/// Icon button for navigation and actions
class HBIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool showBadge;
  final String? badgeText;

  const HBIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 40,
    this.iconColor,
    this.backgroundColor,
    this.showBadge = false,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.accentOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size! / 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size! / 2),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  color: iconColor ?? AppColors.accentOrange,
                  size: size! * 0.6,
                ),
              ),
              if (showBadge)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.accentRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      badgeText ?? '!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
