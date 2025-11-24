import 'package:flutter/material.dart';
import 'package:heybirdy/presentation/components/components.dart';
import 'package:heybirdy/core/constants/colors.dart';
import 'package:heybirdy/data/models/feed_models.dart';

/// Vertical feed of content cards
class ContentFeedSection extends StatelessWidget {
  const ContentFeedSection({
    super.key,
    required this.title,
    required this.contentItems,
    this.onContentTap,
    this.onViewAllTap,
    this.isLoading = false,
  });

  final String title;
  final List<ContentItem> contentItems;
  final Function(ContentItem)? onContentTap;
  final VoidCallback? onViewAllTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HBSectionHeader(title: title),
            const Spacer(),
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
        if (isLoading)
          const _LoadingState()
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contentItems.length,
            itemBuilder: (context, index) {
              final content = contentItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: HBContentCard(
                  content: content.toContentCard(),
                  onTap: () => onContentTap?.call(content),
                ),
              );
            },
          ),
      ],
    );
  }
}

/// Loading state for content feed
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: CircularProgressIndicator(
          color: AppColors.primaryBlurple,
        ),
      ),
    );
  }
}

/// Content item model for feed section
class ContentItem {
  final String id;
  final String title;
  final String imageUrl;
  final String creatorName;
  final String creatorAvatarUrl;
  final int likes;
  final int comments;
  final String contentType;

  const ContentItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.creatorName,
    required this.creatorAvatarUrl,
    required this.likes,
    required this.comments,
    required this.contentType,
  });

  /// Convert to ContentCard model for HBContentCard compatibility
  ContentCard toContentCard() {
    return ContentCard(
      id: id,
      title: title,
      imageUrl: imageUrl,
      creatorName: creatorName,
      creatorAvatarUrl: creatorAvatarUrl,
      likes: likes,
      comments: comments,
      contentType: contentType,
    );
  }
}
