import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureFlags {
  static const bool courses = false;
  static const bool liveEvents = false;
  static const bool aiRecommendations = false;
  static const bool advancedAffiliate = false;
  static const bool creatorShop = false;
  static const bool comments = false;

  // MVP always on
  static const bool authentication = true;
  static const bool contentFeed = true;
  static const bool creatorUpload = true;
  static const bool affiliate = true;
  static const bool wallet = true;
  static const bool adminPanel = true;
  static const bool onboarding = true;
}

final featureFlagsProvider = Provider((ref) => FeatureFlags());
