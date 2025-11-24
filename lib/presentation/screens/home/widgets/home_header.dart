import 'package:flutter/material.dart';
import 'package:heybirdy/presentation/components/components.dart';
import 'package:heybirdy/core/constants/colors.dart';

/// Home header with greeting, notification icon, and search bar
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    required this.greeting,
    required this.onNotificationTap,
    required this.onSearchChanged,
    required this.onFilterTap,
    this.showSearch = true,
  });

  final String userName;
  final String greeting;
  final VoidCallback onNotificationTap;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;
  final bool showSearch;

  String _getMotivationalMessage() {
    final messages = [
      'Ready to create something amazing today?',
      'Let\'s make today productive!',
      'Time to share your creativity!',
      'What will you create today?',
      'Your audience is waiting!',
    ];
    final now = DateTime.now();
    final index = now.day % messages.length;
    return messages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getMotivationalMessage(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.mediumText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlurple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.primaryBlurple,
                  size: 24,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          if (showSearch)
            HBSearchInput(
              hintText: 'Search creators, content, topics...',
              showFilterButton: true,
              showClearButton: false,
              onChanged: onSearchChanged,
              onFilterTap: onFilterTap,
            ),
        ],
      ),
    );
  }
}
