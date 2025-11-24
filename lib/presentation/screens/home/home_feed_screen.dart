import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/home_provider.dart';
import '../../../data/models/feed_models.dart';
import '../../../core/constants/colors.dart';
import 'widgets/home_header.dart';
import 'widgets/home_category_tabs.dart';
import 'widgets/home_feed_content.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).loadInitialData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    // Handle errors
    ref.listen(homeProvider, (_, state) {
      if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error!)),
        );
        homeNotifier.clearError();
      }
    });

    return SafeArea(
      child: homeState.isLoading && homeState.contentFeed.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryBlurple,
              ),
            )
          : Column(
              children: [
                // Header
                HomeHeader(
                  userName: 'Alex',
                  greeting: _getGreeting(),
                  onNotificationTap: () => _handleNotificationTap(),
                  onSearchChanged: (value) =>
                      homeNotifier.updateSearchQuery(value),
                  onFilterTap: () => _handleFilterTap(),
                  showSearch: false,
                ),

                // Category Tabs
                HomeCategoryTabs(
                  tabController: _tabController,
                  tabs: const ['For You', 'Following', 'Trending', 'New'],
                ),

                // Debug Info
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: AppColors.offWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DEBUG: Loading=${homeState.isLoading}',
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.mediumText),
                      ),
                      Text(
                        'Feed=${homeState.contentFeed.length}, Featured=${homeState.featuredContent != null ? homeState.featuredContent!.title.substring(0, 15) : "none"}',
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.mediumText),
                      ),
                      Text(
                        'People=${homeState.peopleLoving.length}, Error=${homeState.error ?? "none"}',
                        style: TextStyle(
                          fontSize: 9,
                          color: homeState.error != null
                              ? AppColors.accentRed
                              : AppColors.mediumText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: homeState.contentFeed.isEmpty && !homeState.isLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.inbox_outlined,
                                    size: 64, color: AppColors.lightText),
                                SizedBox(height: 16),
                                Text(
                                  'No content available',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Content will appear here',
                                  style: TextStyle(color: AppColors.mediumText),
                                ),
                              ],
                            ),
                          ),
                        )
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            _buildFeedContent(
                                'For You', homeState, homeNotifier),
                            _buildFeedContent(
                                'Following', homeState, homeNotifier),
                            _buildFeedContent(
                                'Trending', homeState, homeNotifier),
                            _buildFeedContent('New', homeState, homeNotifier),
                        ],
                      ),
                ),
              ],
            ),
    );
  }

  // Navigation Handlers
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning, Alex!';
    } else if (hour < 17) {
      return 'Good afternoon, Alex!';
    } else {
      return 'Good evening, Alex!';
    }
  }

  void _handleNotificationTap() {
    context.go('/profile/notifications');
  }

  void _handleFilterTap() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const _FilterBottomSheet(),
    );
  }

  void _handleFeaturedTap() {
    if (mockForYou.isNotEmpty) {
      context.go('/content/${mockForYou.first.id}');
    }
  }

  void _handleViewAllFeatured() {
    context.go('/featured');
  }

  void _handleProfileTap(Creator creator) {
    context.go('/profile/${creator.id}');
  }

  void _handleContentTap(ContentCard content) {
    context.go('/content/${content.id}');
  }

  void _handleViewAllContent(String type) {
    context.go('/content?type=${type.toLowerCase().replaceAll(' ', '-')}');
  }

  Widget _buildFeedContent(
      String type, HomeState homeState, HomeNotifier homeNotifier) {
    return HomeFeedContent(
      type: type,
      featuredContent: homeState.featuredContent,
      peopleLoving: homeState.peopleLoving,
      contentFeed: homeState.contentFeed,
      isLoading: homeState.isLoading,
      onFeaturedTap: () => _handleFeaturedTap(),
      onViewAllFeatured: () => _handleViewAllFeatured(),
      onProfileTap: (profile) => _handleProfileTap(profile),
      onContentTap: (content) => _handleContentTap(content),
      onViewAllContent: (type) => _handleViewAllContent(type),
    );
  }
}

/// Filter bottom sheet for content filtering
class _FilterBottomSheet extends StatelessWidget {
  const _FilterBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Filter Content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Filter options
          const Text('Content Type'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['All', 'Videos', 'Articles', 'Podcasts', 'Courses']
                .map((type) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Apply filter logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Filter by: $type')),
                        );
                      },
                      child: Chip(label: Text(type)),
                    ))
                .toList(),
          ),

          const SizedBox(height: 20),
          const Text('Sort By'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Recent', 'Popular', 'Trending']
                .map((sort) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Apply sorting logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sort by: $sort')),
                        );
                      },
                      child: Chip(label: Text(sort)),
                    ))
                .toList(),
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlurple,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
