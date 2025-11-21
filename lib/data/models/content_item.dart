import 'package:equatable/equatable.dart';

class ContentItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String mediaUrl;
  final String creatorId;
  final int views;
  final String affiliateLink;

  const ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.creatorId,
    this.views = 0,
    this.affiliateLink = '',
  });

  @override
  List<Object> get props =>
      [id, title, description, mediaUrl, creatorId, views, affiliateLink];
}
