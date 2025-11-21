import 'package:equatable/equatable.dart';

class ContentItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String mediaUrl;
  final String creatorId;
  final int views;
  final String affiliateLink;
  final List<String> tags; // For interest matching

  const ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.creatorId,
    this.views = 0,
    this.affiliateLink = '',
    this.tags = const [],
  });

  @override
  List<Object?> get props => [id, title, description, mediaUrl, creatorId, views, affiliateLink, tags];
}

class CreatorCardData extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final String bio;
  final int followers;
  final String link;

  const CreatorCardData({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    this.followers = 0,
    this.link = '',
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, bio, followers, link];
}