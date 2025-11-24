import 'package:flutter/material.dart';
import 'package:heybirdy/core/constants/colors.dart';
import 'package:heybirdy/presentation/components/components.dart';
import 'package:heybirdy/data/models/feed_models.dart';
import 'content_feed_section.dart';

class ContentGridSection extends StatelessWidget {
  const ContentGridSection({
    super.key,
    required this.title,
    required this.contentItems,
    this.onContentTap,
    this.onViewAllTap,
  });

  final String title;
  final List<ContentItem> contentItems;
  final Function(ContentItem)? onContentTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            if (onViewAllTap != null)
              TextButton(
                onPressed: onViewAllTap,
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: AppColors.primaryBlurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: contentItems.length >= 6 ? 6 : contentItems.length,
          itemBuilder: (context, index) {
            final item = contentItems[index];
            return HBContentCard(
              content: ContentCard(
                id: item.id,
                title: item.title,
                imageUrl: item.imageUrl,
                creatorName: item.creatorName,
                creatorAvatarUrl: item.creatorAvatarUrl,
                likes: item.likes,
                comments: item.comments,
                contentType: item.contentType,
              ),
              onTap: () => onContentTap?.call(item),
            );
          },
        ),
      ],
    );
  }
}
