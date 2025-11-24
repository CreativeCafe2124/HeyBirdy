import 'package:flutter/material.dart';
import 'package:heybirdy/core/constants/colors.dart';

/// Loading state for home screen sections
class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({
    super.key,
    this.type = LoadingType.general,
  });

  final LoadingType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoadingType.featured:
        return _buildFeaturedLoading();
      case LoadingType.quickActions:
        return _buildQuickActionsLoading();
      case LoadingType.peopleLoving:
        return _buildPeopleLovingLoading();
      case LoadingType.contentFeed:
        return _buildContentFeedLoading();
      case LoadingType.general:
        return _buildGeneralLoading();
    }
  }

  Widget _buildGeneralLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primaryBlurple,
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Loading amazing content...',
            style: TextStyle(
              color: AppColors.mediumText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedLoading() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardBackground,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryBlurple,
        ),
      ),
    );
  }

  Widget _buildQuickActionsLoading() {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < 2 ? 12 : 0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.cardBackground,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlurple,
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeopleLovingLoading() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors.cardBackground,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryBlurple,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentFeedLoading() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          height: 160,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.cardBackground,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryBlurple,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}

/// Types of loading states
enum LoadingType {
  general,
  featured,
  quickActions,
  peopleLoving,
  contentFeed,
}

/// Error state for home screen
class HomeErrorState extends StatelessWidget {
  const HomeErrorState({
    super.key,
    required this.error,
    required this.onRetry,
    this.type = ErrorType.general,
  });

  final String error;
  final VoidCallback onRetry;
  final ErrorType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ErrorType.featured:
        return _buildFeaturedError();
      case ErrorType.peopleLoving:
        return _buildPeopleLovingError();
      case ErrorType.contentFeed:
        return _buildContentFeedError();
      case ErrorType.general:
        return _buildGeneralError();
    }
  }

  Widget _buildGeneralError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.accentRed,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.mediumText,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlurple,
                foregroundColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedError() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.accentRed.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.accentRed,
            ),
            const SizedBox(height: 8),
            const Text(
              'Failed to load featured content',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.mediumText,
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleLovingError() {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.accentRed,
              size: 24,
            ),
            const SizedBox(height: 4),
            const Text(
              'Failed to load profiles',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.mediumText,
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentFeedError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.accentRed,
            ),
            const SizedBox(height: 8),
            const Text(
              'Failed to load content',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.mediumText,
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Types of error states
enum ErrorType {
  general,
  featured,
  peopleLoving,
  contentFeed,
}

/// Empty state for home screen
class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 48,
              color: AppColors.mediumText,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.mediumText,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
