import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/feed_models.dart';

/// Profile card for circular avatars with names (People are loving today)
class HBProfileCard extends StatelessWidget {
  final Creator creator;
  final VoidCallback? onTap;
  final double? size;
  final bool showName;
  final double? avatarRadius;

  const HBProfileCard({
    super.key,
    required this.creator,
    this.onTap,
    this.size = 80,
    this.showName = true,
    this.avatarRadius = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          // Circular Avatar
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(avatarRadius!),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundImage: NetworkImage(creator.avatarUrl),
                backgroundColor: Colors.grey[300],
                child: Stack(
                  children: [
                    // Avatar image will be loaded by backgroundImage
                    Container(),
                    // Optional: Add online status indicator
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showName) ...[
            const SizedBox(height: 8),
            // Creator Name
            Text(
              creator.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
