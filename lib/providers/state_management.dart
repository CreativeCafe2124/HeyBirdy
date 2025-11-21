import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/referral_service.dart';
import '../app/app_startup.dart';
import '../data/models/feed_models.dart'; // Added import for feed_models.dart

enum AppRole { guest, learner, creator, affiliate, moderator, admin }

final roleProvider = StateProvider<AppRole?>((ref) => AppRole.guest);
final isAuthenticatedProvider = StateProvider<bool>((ref) => false);
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final currentTabProvider = StateProvider<int>((ref) => 0);

final onboardingCompleteProvider = StateProvider<bool>((ref) => false);

final selectedInterestsProvider = StateProvider<Set<String>>((ref) => {});

// Mock Data for Home Feed
const List<ContentItem> _mockContent = [
  ContentItem(
    id: '1',
    title: 'Healthy Smoothie Recipes',
    description: '5 quick recipes for your morning boost',
    mediaUrl: 'https://placehold.co/300x200/ff8c00/ffffff?text=Smoothies',
    creatorId: 'jane',
    views: 1245,
    tags: ['Fitness', 'Lifestyle'],
  ),
  ContentItem(
    id: '2',
    title: 'Financial Freedom Guide',
    description: 'Step-by-step to financial independence',
    mediaUrl: 'https://placehold.co/300x200/3cb371/ffffff?text=Finance',
    creatorId: 'michael',
    views: 890,
    tags: ['Finance', 'Business'],
    affiliateLink: 'https://affiliate.com/finance',
  ),
  ContentItem(
    id: '3',
    title: 'Mastering Digital Art',
    description: 'Pro tips for Photoshop and Illustrator',
    mediaUrl: 'https://placehold.co/300x200/1e90ff/ffffff?text=Art',
    creatorId: 'anya',
    views: 2345,
    tags: ['Beauty', 'Personal Growth'],
  ),
  ContentItem(
    id: '4',
    title: 'Fitness Rose Yoga Flow',
    description: '30-min beginner yoga for flexibility',
    mediaUrl: 'https://placehold.co/300x200/a3e34c/000000?text=Yoga',
    creatorId: 'rose',
    views: 567,
    tags: ['Fitness'],
  ),
  ContentItem(
    id: '5',
    title: 'Bizam Arlew Cooking Class',
    description: 'Easy weeknight dinners under 30 mins',
    mediaUrl: 'https://placehold.co/300x200/4ce3e3/000000?text=Cooking',
    creatorId: 'bizam',
    views: 987,
    tags: ['Lifestyle'],
  ),
];

const List<CreatorCardData> _mockTrendingCreators = [
  CreatorCardData(
    id: 'emily',
    name: 'Emily J.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=E',
    bio: 'Fitness enthusiast and yoga instructor.',
    followers: 15000,
  ),
  CreatorCardData(
    id: 'mark',
    name: 'Mark T.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=M',
    bio: 'Financial advisor and business coach.',
    followers: 20000,
  ),
  CreatorCardData(
    id: 'john',
    name: 'John K.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=J',
    bio: 'Digital artist and graphic designer.',
    followers: 10000,
  ),
  CreatorCardData(
    id: 'sarah',
    name: 'Sarah L.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=S',
    bio: 'Lifestyle blogger and travel expert.',
    followers: 18000,
  ),
];

final feedProvider = Provider<List<ContentItem>>((ref) {
  final interests = ref.watch(selectedInterestsProvider);
  const allContent = _mockContent;
  if (interests.isEmpty) return allContent;
  return allContent.where((item) => 
    interests.any((interest) => 
      item.tags.any((tag) => tag.toLowerCase().contains(interest.toLowerCase()))
    )
  ).toList();
});

final trendingCreatorsProvider = Provider<List<CreatorCardData>>((ref) => _mockTrendingCreators);

final referralServiceProvider = Provider((ref) => ReferralService());

final appStartupProvider = FutureProvider((ref) async {
  await appStartup(ref);
});
