import 'package:flutter/material.dart';
import 'package:heybirdy/presentation/components/components.dart';
import 'package:heybirdy/data/models/feed_models.dart';

/// Horizontal scrolling list of profile cards
class PeopleLovingSection extends StatelessWidget {
  const PeopleLovingSection({
    super.key,
    required this.profiles,
    this.onProfileTap,
    this.title = 'People are loving today',
    this.onSeeAllTap,
  });

  final List<Profile> profiles;
  final Function(Profile)? onProfileTap;
  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HBSectionHeader(
          title: title,
          actionText: onSeeAllTap != null ? 'See all' : null,
          onActionTap: onSeeAllTap,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return HBProfileCard(
                creator: profile.toCreator(),
                onTap: () => onProfileTap?.call(profile),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Profile model for people loving section
class Profile {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  const Profile({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
  });

  /// Convert to Creator model for HBProfileCard compatibility
  Creator toCreator() {
    return Creator(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      isOnline: isOnline,
    );
  }
}
