import 'package:flutter/material.dart';
import '../../data/models/feed_models.dart';

// Helper for the gradient button/backgrounds (matching the app's style)
const Color primaryColor = Color(0xFF4C3EE3);
const Color secondaryColor = Color(0xFF8A2BE2);
const LinearGradient buttonGradient = LinearGradient(
  colors: [primaryColor, secondaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class ContentCard extends StatelessWidget {
  final ContentItem content;
  final bool isVertical;

  const ContentCard._internal({super.key, required this.content, required this.isVertical});

  factory ContentCard({Key? key, required ContentItem content}) {
    return ContentCard._internal(key: key, content: content, isVertical: true);
  }

  factory ContentCard.horizontal({Key? key, required ContentItem content}) {
    return ContentCard._internal(key: key, content: content, isVertical: false);
  }

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Container(
        width: 110,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                content.mediaUrl,
                width: 110,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    content.title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                content.mediaUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content Title
                  Text(
                    content.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Creator Name
                      Text(
                        content.creatorId,
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

/// The main CTA banner for sharing content
class GenerateLinkBanner extends StatelessWidget {
  final List<CreatorCardData> trendingCreators;

  const GenerateLinkBanner({super.key, required this.trendingCreators});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            primaryColor.withAlpha((0.1 * 255).round()),
            secondaryColor.withAlpha((0.1 * 255).round())
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Trending Creators Avatars
          SizedBox(
            height: 40,
            child: Stack(
              children: List.generate(
                trendingCreators.length.clamp(0, 4), // Show up to 4
                (index) => Positioned(
                  left: index * 24.0, // Overlap the avatars
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(trendingCreators[index].avatarUrl),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Creator Names (simulating the UI text)
          Text(
            trendingCreators.map((c) => c.name).join(', '),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Gradient CTA Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: buttonGradient,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withAlpha((0.4 * 255).round()),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Generate your link',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Earn by sharing content',
            style: TextStyle(fontSize: 12, color: primaryColor),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thanks! ❤️',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
