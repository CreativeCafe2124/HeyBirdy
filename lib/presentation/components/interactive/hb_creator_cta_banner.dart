import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/feed_models.dart';
import '../buttons/hb_primary_button.dart';
import '../user/hb_avatar_stack.dart';

/// Creator CTA banner with avatar stack and gradient button
class HBCreatorCTABanner extends StatelessWidget {
  final List<Creator> trendingCreators;
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final String? footerText;

  const HBCreatorCTABanner({
    super.key,
    required this.trendingCreators,
    this.title,
    this.subtitle,
    this.buttonText = 'Generate your link',
    this.onButtonTap,
    this.footerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlurple.withValues(alpha: 0.1),
            AppColors.accentOrange.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Trending Creators Avatars
          HBAvatarStack(
            creators: trendingCreators,
            avatarRadius: 20,
            overlap: 24,
            maxVisible: 4,
          ),
          const SizedBox(height: 10),
          // Creator Names (simulating the UI text)
          Text(
            subtitle ?? 'Emily J. Mark T. John K.',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 10),
          // Gradient CTA Button
          HBPrimaryButton(
            text: buttonText!,
            onPressed: onButtonTap,
            width: double.infinity,
          ),
          const SizedBox(height: 10),
          Text(
            title ?? 'Earn by sharing content',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primaryBlurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            footerText ?? 'Thanks! ❤️',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.mediumText,
            ),
          ),
        ],
      ),
    );
  }
}
