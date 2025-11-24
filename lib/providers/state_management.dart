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
    id: '1',
    title: 'Healthy Smoothie Recipes',
    imageUrl: 'https://placehold.co/300x200/ff8c00/ffffff?text=Smoothies',
    creatorName: 'Jane D.',
    creatorAvatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=J',
  ),
  ContentCard(
    id: '2',
    title: 'Web Development Basics',
    imageUrl: 'https://placehold.co/300x200/0066cc/ffffff?text=WebDev',
    creatorName: 'John K.',
    creatorAvatarUrl: 'https://placehold.co/40x40/cc0066/ffffff?text=K',
  ),
  ContentCard(
    id: '3',
    title: 'Yoga for Beginners',
    imageUrl: 'https://placehold.co/300x200/00cc66/ffffff?text=Yoga',
    creatorName: 'Sarah L.',
    creatorAvatarUrl: 'https://placehold.co/40x40/6600cc/ffffff?text=S',
  ),
];

const List<Creator> _mockTrendingCreators = [
  Creator(
    id: '1',
    name: 'Jane D.',
    avatarUrl: 'https://placehold.co/60x60/4c3ee3/ffffff?text=J',
  ),
  Creator(
    id: '2',
    name: 'John K.',
    avatarUrl: 'https://placehold.co/60x60/cc0066/ffffff?text=K',
  ),
  Creator(
    id: '3',
    name: 'Sarah L.',
    avatarUrl: 'https://placehold.co/60x60/6600cc/ffffff?text=S',
  ),
  Creator(
    id: '4',
    name: 'Emily J.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=E',
  ),
  Creator(
    id: '5',
    name: 'Mark T.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=M',
  ),
  Creator(
    id: '6',
    name: 'John K.',
    avatarUrl: 'https://placehold.co/40x40/4c3ee3/ffffff?text=J',
  ),
  Creator(
    id: '7',
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
