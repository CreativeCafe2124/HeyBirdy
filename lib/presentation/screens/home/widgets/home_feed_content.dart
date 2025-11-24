import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heybirdy/data/models/feed_models.dart';
import 'content_grid_section.dart';
import 'people_loving_section.dart';
import 'content_feed_section.dart';
import 'package:heybirdy/core/constants/colors.dart';
import 'package:heybirdy/presentation/components/interactive/hb_creator_cta_banner.dart';

/// Feed content widget that can be used in home screen
class HomeFeedContent extends StatelessWidget {
  const HomeFeedContent({
    super.key,
    required this.type,
    this.featuredContent,
    this.peopleLoving = const [],
    this.contentFeed = const [],
    this.isLoading = false,
    required this.onFeaturedTap,
    required this.onViewAllFeatured,
    required this.onProfileTap,
    required this.onContentTap,
    required this.onViewAllContent,
    this.onViewAllPeopleLoving,
    this.onViewAllTrendingCreators,
  });

  final String type;
  final ContentCard? featuredContent;
  final List<Creator> peopleLoving;
  final List<ContentCard> contentFeed;
  final bool isLoading;
  final VoidCallback onFeaturedTap;
  final VoidCallback onViewAllFeatured;
  final Function(Creator) onProfileTap;
  final Function(ContentCard) onContentTap;
  final Function(String) onViewAllContent;
  final VoidCallback? onViewAllPeopleLoving;
  final VoidCallback? onViewAllTrendingCreators;

  @override
  Widget build(BuildContext context) {
    // Show loading state
    if (isLoading && peopleLoving.isEmpty && contentFeed.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryBlurple,
        ),
      );
    }

    // Show empty state
    if (!isLoading && contentFeed.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inbox_outlined,
                  size: 64, color: AppColors.lightText),
              const SizedBox(height: 16),
              Text(
                'No $type content',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Check back later for updates',
                style: TextStyle(color: AppColors.mediumText),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (peopleLoving.isNotEmpty)
            PeopleLovingSection(
              profiles: peopleLoving
                  .map((creator) => Profile(
                        id: creator.id,
                        name: creator.name,
                        avatarUrl: creator.avatarUrl,
                        isOnline: creator.isOnline,
                      ))
                  .toList(),
              onProfileTap: (profile) => onProfileTap(peopleLoving
                  .firstWhere((creator) => creator.id == profile.id)),
              title: 'People are loving today',
              onSeeAllTap: onViewAllPeopleLoving,
            )
          else if (!isLoading)
            const SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  'No profiles available',
                  style: TextStyle(color: AppColors.mediumText),
                ),
              ),
            )
          else
            const SizedBox(
              height: 120,
              child: Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryBlurple),
              ),
            ),
          const SizedBox(height: 24),
          if (contentFeed.isNotEmpty)
            ContentGridSection(
              title: 'For you',
              contentItems: contentFeed
                  .map((content) => ContentItem(
                        id: content.id,
                        title: content.title,
                        imageUrl: content.imageUrl,
                        creatorName: content.creatorName,
                        creatorAvatarUrl: content.creatorAvatarUrl,
                        likes: content.likes,
                        comments: content.comments,
                        contentType: content.contentType,
                      ))
                  .toList(),
              onContentTap: (ContentItem contentItem) {
                final contentCard = contentFeed
                    .firstWhere((content) => content.id == contentItem.id);
                onContentTap(contentCard);
              },
              onViewAllTap: () => onViewAllContent(type),
            )
          else if (!isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  'No content available',
                  style: TextStyle(color: AppColors.mediumText),
                ),
              ),
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlurple,
                ),
              ),
            ),
          const SizedBox(height: 24),
          HBCreatorCTABanner(
            trendingCreators: peopleLoving
                .map((p) => Creator(
                      id: p.id,
                      name: p.name,
                      avatarUrl: p.avatarUrl,
                    ))
                .toList(),
            buttonText: 'Generate your link',
            title: 'Earn by sharing content',
            footerText: 'Thanks! ❤️',
            onButtonTap: () => context.go('/affiliate'),
          ),
          const SizedBox(height: 24),
          if (peopleLoving.isNotEmpty)
            PeopleLovingSection(
              profiles: peopleLoving
                  .map((creator) => Profile(
                        id: creator.id,
                        name: creator.name,
                        avatarUrl: creator.avatarUrl,
                        isOnline: creator.isOnline,
                      ))
                  .toList(),
              onProfileTap: (profile) => onProfileTap(peopleLoving
                  .firstWhere((creator) => creator.id == profile.id)),
              title: 'Trending creators',
              onSeeAllTap: onViewAllTrendingCreators,
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
