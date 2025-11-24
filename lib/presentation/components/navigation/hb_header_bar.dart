import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../buttons/hb_icon_button.dart';

/// Header bar with greeting, time, and sun icon (matches home screen design)
class HBHeaderBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showGreeting;
  final bool showTime;
  final bool showSunIcon;

  const HBHeaderBar({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.showGreeting = true,
    this.showTime = true,
    this.showSunIcon = true,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 🌤️';
    return 'Good evening 🌙';
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - Greeting/Title or leading widget
              leading ??
                  (showGreeting
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? _getGreeting(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppColors.darkText,
                              ),
                            ),
                            if (showTime) ...[
                              const SizedBox(height: 4),
                              Text(
                                subtitle ?? _getCurrentTime(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mediumText,
                                ),
                              ),
                            ],
                          ],
                        )
                      : (title != null
                          ? Text(
                              title!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                            )
                          : const SizedBox.shrink())),
              // Right side - Actions or sun icon
              Row(
                children: actions ??
                    (showSunIcon
                        ? [
                            HBIconButton(
                              icon: Icons.wb_sunny,
                              size: 52,
                              backgroundColor:
                                  AppColors.accentOrange.withValues(alpha: 0.1),
                              iconColor: AppColors.accentOrange,
                            ),
                          ]
                        : []),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
