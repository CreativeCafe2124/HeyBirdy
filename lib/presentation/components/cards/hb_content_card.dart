import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/feed_models.dart';

/// Content card for horizontal scrolling lists (For you section)
class HBContentCard extends StatelessWidget {
  final ContentCard content;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const HBContentCard({
    super.key,
    required this.content,
    this.onTap,
    this.width = 200,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content Image
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    content.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.cardBackground,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.mediumText,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Content Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Content Title
                      Text(
                        content.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Creator Info
                      Row(
                        children: [
                          // Creator Avatar
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                NetworkImage(content.creatorAvatarUrl),
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(width: 8),
                          // Creator Name
                          Expanded(
                            child: Text(
                              content.creatorName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.mediumText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
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
