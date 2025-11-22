import 'package:shared_preferences/shared_preferences.dart';
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

final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_complete') ?? false;
});

final selectedInterestsProvider = StateProvider<Set<String>>((ref) => {});

// Mock Data for Home Feed
const List<ContentCard> _mockContent = [
  ContentCard(
    title: 'Healthy Smoothie Recipes',
    imageUrl: 'https://placehold.co/300x200/ff8c00/ffffff?text=Smoothies',
    creatorName: 'Jane D.',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=J',
  ),
  ContentCard(
    title: 'Financial Freedom Guide',
    imageUrl: 'https://placehold.co/300x200/3cb371/ffffff?text=Finance',
    creatorName: 'Michael S.',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=M',
  ),
  ContentCard(
    title: 'Mastering Digital Art',
    imageUrl: 'https://placehold.co/300x200/1e90ff/ffffff?text=Art',
    creatorName: 'Anya P.',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=A',
  ),
  ContentCard(
    title: 'Fitness Rose Yoga Flow',
    imageUrl: 'https://placehold.co/300x200/a3e34c/000000?text=Yoga',
    creatorName: 'Rose',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=R',
  ),
  ContentCard(
    title: 'Bizam Arlew Cooking Class',
    imageUrl: 'https://placehold.co/300x200/4ce3e3/000000?text=Cooking',
    creatorName: 'Bizam',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=B',
  ),
];

const List<Creator> _mockTrendingCreators = [
  Creator(
    name: 'Emily J.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=E',
  ),
  Creator(
    name: 'Mark T.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=M',
  ),
  Creator(
    name: 'John K.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=J',
  ),
  Creator(
    name: 'Sarah L.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=S',
  ),
];

final feedProvider = Provider<List<ContentCard>>((ref) {
  const allContent = _mockContent;
  return allContent;
});

final trendingCreatorsProvider = Provider<List<Creator>>((ref) => _mockTrendingCreators);

final referralServiceProvider = Provider((ref) => ReferralService());

final appStartupProvider = FutureProvider((ref) async {
  await appStartup(ref);
});
