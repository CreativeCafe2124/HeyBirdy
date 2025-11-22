import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/feed_models.dart';

/// Avatar stack for showing multiple overlapping user avatars
class HBAvatarStack extends StatelessWidget {
  final List<Creator> creators;
  final double avatarRadius;
  final double overlap;
  final int maxVisible;
  final Widget? trailing;

  const HBAvatarStack({
    super.key,
    required this.creators,
    this.avatarRadius = 20,
    this.overlap = 24,
    this.maxVisible = 4,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCreators = creators.take(maxVisible).toList();
    final remainingCount = creators.length - maxVisible;

    return SizedBox(
      height: avatarRadius * 2,
      child: Stack(
        children: [
          ...visibleCreators.asMap().entries.map((entry) {
            final index = entry.key;
            final creator = entry.value;
            return Positioned(
              left: index * overlap,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: avatarRadius - 2,
                  backgroundImage: NetworkImage(creator.avatarUrl),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            );
          }),
          if (remainingCount > 0)
            Positioned(
              left: maxVisible * overlap,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: avatarRadius - 2,
                  backgroundColor: AppColors.primaryBlurple,
                  child: Text(
                    '+$remainingCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (trailing != null)
            Positioned(
              left: (creators.length.clamp(0, maxVisible) +
                          (remainingCount > 0 ? 1 : 0)) *
                      overlap +
                  8,
              child: trailing!,
            ),
        ],
      ),
    );
  }
}
