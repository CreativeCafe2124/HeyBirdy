import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';
import '../data/models/feed_models.dart';

/// Home screen state
@immutable
class HomeState {
  const HomeState({
    this.isLoading = false,
    this.searchQuery = '',
    this.selectedCategory = 'For You',
    this.featuredContent,
    this.peopleLoving = const [],
    this.contentFeed = const [],
    this.error,
    this.featuredError,
    this.peopleLovingError,
    this.contentFeedError,
  });

  final bool isLoading;
  final String searchQuery;
  final String selectedCategory;
  final ContentCard? featuredContent;
  final List<Creator> peopleLoving;
  final List<ContentCard> contentFeed;
  final String? error;
  final String? featuredError;
  final String? peopleLovingError;
  final String? contentFeedError;

  HomeState copyWith({
    bool? isLoading,
    String? searchQuery,
    String? selectedCategory,
    ContentCard? featuredContent,
    List<Creator>? peopleLoving,
    List<ContentCard>? contentFeed,
    String? error,
    String? featuredError,
    String? peopleLovingError,
    String? contentFeedError,
    bool clearErrors = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      featuredContent: featuredContent ?? this.featuredContent,
      peopleLoving: peopleLoving ?? this.peopleLoving,
      contentFeed: contentFeed ?? this.contentFeed,
      error: clearErrors ? null : (error ?? this.error),
      featuredError: clearErrors ? null : (featuredError ?? this.featuredError),
      peopleLovingError:
          clearErrors ? null : (peopleLovingError ?? this.peopleLovingError),
      contentFeedError:
          clearErrors ? null : (contentFeedError ?? this.contentFeedError),
    );
  }
}

/// Home screen notifier for state management
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  /// Load initial data for the home screen
  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, clearErrors: true);

    try {
      // Load featured content separately
      await _loadFeaturedContent();

      // Load people loving section separately
      await _loadPeopleLoving();

      // Load content feed based on selected category
      await _loadContentForCategory(state.selectedCategory);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load home data: $e',
      );
    }
  }

  /// Load featured content separately
  Future<void> _loadFeaturedContent() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final featured = mockForYou.isNotEmpty ? mockForYou.first : null;
      state = state.copyWith(featuredContent: featured);
    } catch (e) {
      state =
          state.copyWith(featuredError: 'Failed to load featured content: $e');
    }
  }

  /// Load people loving section separately
  Future<void> _loadPeopleLoving() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final people = mockPeopleLoving.take(5).toList();
      state = state.copyWith(peopleLoving: people);
    } catch (e) {
      state = state.copyWith(peopleLovingError: 'Failed to load profiles: $e');
    }
  }

  /// Load content for specific category
  Future<void> _loadContentForCategory(String category) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final feed = _getContentForCategory(category);
      state = state.copyWith(contentFeed: feed);
    } catch (e) {
      state = state.copyWith(
          contentFeedError: 'Failed to load $category content: $e');
    }
  }

  /// Retry loading featured content
  Future<void> retryFeaturedContent() async {
    await _loadFeaturedContent();
  }

  /// Retry loading people loving section
  Future<void> retryPeopleLoving() async {
    await _loadPeopleLoving();
  }

  /// Retry loading content feed
  Future<void> retryContentFeed() async {
    await _loadContentForCategory(state.selectedCategory);
  }

  /// Update search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    // TODO: Implement search logic
  }

  /// Update selected category
  void updateCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _loadContentForCategory(category);
  }

  /// Get content for category
  List<ContentCard> _getContentForCategory(String category) {
    switch (category) {
      case 'For You':
        return mockForYou;
      case 'Following':
        return mockForYou.take(5).toList();
      case 'Trending':
        return mockForYou.skip(2).take(8).toList();
      case 'New':
        return mockForYou.skip(5).toList();
      default:
        return mockForYou;
    }
  }

  /// Refresh content
  Future<void> refresh() async {
    await loadInitialData();
  }

  /// Clear any errors
  void clearError() {
    state = state.copyWith(clearErrors: true);
  }

  /// Clear specific error
  void clearFeaturedError() {
    state = state.copyWith(featuredError: null);
  }

  void clearPeopleLovingError() {
    state = state.copyWith(peopleLovingError: null);
  }

  void clearContentFeedError() {
    state = state.copyWith(contentFeedError: null);
  }
}

/// Provider for home screen state
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

/// Provider for initial data loading
final homeInitialDataProvider = FutureProvider<void>((ref) async {
  final notifier = ref.read(homeProvider.notifier);
  await notifier.loadInitialData();
});
