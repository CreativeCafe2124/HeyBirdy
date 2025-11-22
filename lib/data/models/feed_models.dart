// --- Data Models for Home Feed ---

/// Represents a piece of content (e.g., a recipe, a guide).
class ContentCard {
  final String title;
  final String imageUrl;
  final String creatorName;
  final String creatorAvatarUrl;

  const ContentCard({
    required this.title,
    required this.imageUrl,
    required this.creatorName,
    required this.creatorAvatarUrl,
  });
}

/// Represents a popular or trending creator.
class Creator {
  final String name;
  final String avatarUrl;

  const Creator({
    required this.name,
    required this.avatarUrl,
  });
}

// --- Mock Data ---

// Placeholder URLs - in a real app, use assets or network images.
const String _placeholderAvatar =
    'https://placehold.co/40x40/4c3ee3/ffffff?text=U';
const String _placeholderContent =
    'https://placehold.co/300x200/4c3ee3/ffffff?text=Content';

final List<Creator> mockPeopleLoving = [
  const Creator(
    name: 'Fitness Rose',
    avatarUrl: 'https://picsum.photos/seed/fitness1/60/60.jpg',
  ),
  const Creator(
    name: 'Lifestyle Pro',
    avatarUrl: 'https://picsum.photos/seed/lifestyle1/60/60.jpg',
  ),
  const Creator(
    name: 'Bizam Arley',
    avatarUrl: 'https://picsum.photos/seed/bizam1/60/60.jpg',
  ),
  const Creator(
    name: 'Tech Guru',
    avatarUrl: 'https://picsum.photos/seed/tech1/60/60.jpg',
  ),
  const Creator(
    name: 'Foodie Queen',
    avatarUrl: 'https://picsum.photos/seed/food1/60/60.jpg',
  ),
  const Creator(
    name: 'Travel Expert',
    avatarUrl: 'https://picsum.photos/seed/travel1/60/60.jpg',
  ),
  const Creator(
    name: 'Music Master',
    avatarUrl: 'https://picsum.photos/seed/music1/60/60.jpg',
  ),
  const Creator(
    name: 'Art Designer',
    avatarUrl: 'https://picsum.photos/seed/art2/60/60.jpg',
  ),
];

final List<ContentCard> mockForYou = [
  const ContentCard(
    title: 'Healthy Smoothie Recipes - 5 Minute Breakfast',
    imageUrl: 'https://picsum.photos/seed/smoothie1/200/100.jpg',
    creatorName: 'Jane D.',
    creatorAvatarUrl: 'https://picsum.photos/seed/jane1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Financial Freedom Guide - Invest Smart',
    imageUrl: 'https://picsum.photos/seed/finance1/200/100.jpg',
    creatorName: 'Michael S.',
    creatorAvatarUrl: 'https://picsum.photos/seed/michael1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Mastering Digital Art - Pro Techniques',
    imageUrl: 'https://picsum.photos/seed/art1/200/100.jpg',
    creatorName: 'Anya P.',
    creatorAvatarUrl: 'https://picsum.photos/seed/anya1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Web Development Bootcamp - Full Stack',
    imageUrl: 'https://picsum.photos/seed/webdev1/200/100.jpg',
    creatorName: 'John K.',
    creatorAvatarUrl: 'https://picsum.photos/seed/john2/40/40.jpg',
  ),
  const ContentCard(
    title: 'Yoga for Beginners - 30 Day Challenge',
    imageUrl: 'https://picsum.photos/seed/yoga1/200/100.jpg',
    creatorName: 'Sarah L.',
    creatorAvatarUrl: 'https://picsum.photos/seed/sarah1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Photography Masterclass - Capture Perfect Shots',
    imageUrl: 'https://picsum.photos/seed/photo1/200/100.jpg',
    creatorName: 'Emily J.',
    creatorAvatarUrl: 'https://picsum.photos/seed/emily1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Cooking Italian Cuisine - Authentic Recipes',
    imageUrl: 'https://picsum.photos/seed/cooking1/200/100.jpg',
    creatorName: 'Marco R.',
    creatorAvatarUrl: 'https://picsum.photos/seed/marco1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Language Learning - Speak Spanish in 30 Days',
    imageUrl: 'https://picsum.photos/seed/spanish1/200/100.jpg',
    creatorName: 'Carlos M.',
    creatorAvatarUrl: 'https://picsum.photos/seed/carlos1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Fitness Training - Build Muscle at Home',
    imageUrl: 'https://picsum.photos/seed/fitness2/200/100.jpg',
    creatorName: 'Alex T.',
    creatorAvatarUrl: 'https://picsum.photos/seed/alex1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Marketing Strategies - Grow Your Business',
    imageUrl: 'https://picsum.photos/seed/marketing1/200/100.jpg',
    creatorName: 'Lisa W.',
    creatorAvatarUrl: 'https://picsum.photos/seed/lisa1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Meditation & Mindfulness - Reduce Stress',
    imageUrl: 'https://picsum.photos/seed/meditation1/200/100.jpg',
    creatorName: 'Zen Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/zen1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Gardening Tips - Grow Your Own Vegetables',
    imageUrl: 'https://picsum.photos/seed/garden1/200/100.jpg',
    creatorName: 'Green Thumb',
    creatorAvatarUrl: 'https://picsum.photos/seed/garden1/40/40.jpg',
  ),
];

final List<Creator> mockTrendingCreators = [
  const Creator(
      name: 'Emily J.',
      avatarUrl: 'https://picsum.photos/seed/emily1/60/60.jpg'),
  const Creator(
      name: 'Mark T.', avatarUrl: 'https://picsum.photos/seed/mark1/60/60.jpg'),
  const Creator(
      name: 'John K.', avatarUrl: 'https://picsum.photos/seed/john1/60/60.jpg'),
  const Creator(
      name: 'Sarah L.',
      avatarUrl: 'https://picsum.photos/seed/sarah1/60/60.jpg'),
  const Creator(
      name: 'Alex R.', avatarUrl: 'https://picsum.photos/seed/alex2/60/60.jpg'),
  const Creator(
      name: 'Maria S.',
      avatarUrl: 'https://picsum.photos/seed/maria1/60/60.jpg'),
  const Creator(
      name: 'David L.',
      avatarUrl: 'https://picsum.photos/seed/david1/60/60.jpg'),
  const Creator(
      name: 'Sophie M.',
      avatarUrl: 'https://picsum.photos/seed/sophie1/60/60.jpg'),
  const Creator(
      name: 'Ryan K.', avatarUrl: 'https://picsum.photos/seed/ryan1/60/60.jpg'),
  const Creator(
      name: 'Nina P.', avatarUrl: 'https://picsum.photos/seed/nina1/60/60.jpg'),
];

// Additional mock data for different sections
final List<ContentCard> mockTrendingContent = [
  const ContentCard(
    title: 'AI Revolution - Future of Technology',
    imageUrl: 'https://picsum.photos/seed/ai1/200/100.jpg',
    creatorName: 'Tech Expert',
    creatorAvatarUrl: 'https://picsum.photos/seed/tech2/40/40.jpg',
  ),
  const ContentCard(
    title: 'Sustainable Living - Eco Friendly Tips',
    imageUrl: 'https://picsum.photos/seed/eco1/200/100.jpg',
    creatorName: 'Green Life',
    creatorAvatarUrl: 'https://picsum.photos/seed/eco1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Cryptocurrency Guide - Bitcoin & Beyond',
    imageUrl: 'https://picsum.photos/seed/crypto1/200/100.jpg',
    creatorName: 'Crypto Guru',
    creatorAvatarUrl: 'https://picsum.photos/seed/crypto1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Fashion Trends - 2024 Style Guide',
    imageUrl: 'https://picsum.photos/seed/fashion1/200/100.jpg',
    creatorName: 'Style Queen',
    creatorAvatarUrl: 'https://picsum.photos/seed/fashion1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Pet Training - Raise Happy Dogs',
    imageUrl: 'https://picsum.photos/seed/pets1/200/100.jpg',
    creatorName: 'Pet Whisperer',
    creatorAvatarUrl: 'https://picsum.photos/seed/pets1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Home Renovation - DIY Projects',
    imageUrl: 'https://picsum.photos/seed/home1/200/100.jpg',
    creatorName: 'DIY Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/diy1/40/40.jpg',
  ),
];

final List<ContentCard> mockNewContent = [
  const ContentCard(
    title: 'Podcast Production - Start Your Show',
    imageUrl: 'https://picsum.photos/seed/podcast1/200/100.jpg',
    creatorName: 'Audio Pro',
    creatorAvatarUrl: 'https://picsum.photos/seed/audio1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Video Editing - Create Viral Content',
    imageUrl: 'https://picsum.photos/seed/video1/200/100.jpg',
    creatorName: 'Video King',
    creatorAvatarUrl: 'https://picsum.photos/seed/video1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Social Media Marketing - Go Viral',
    imageUrl: 'https://picsum.photos/seed/social1/200/100.jpg',
    creatorName: 'Marketing Pro',
    creatorAvatarUrl: 'https://picsum.photos/seed/social1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Writing Skills - Become Bestselling Author',
    imageUrl: 'https://picsum.photos/seed/writing1/200/100.jpg',
    creatorName: 'Write Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/write1/40/40.jpg',
  ),
  const ContentCard(
    title: 'Public Speaking - Command the Room',
    imageUrl: 'https://picsum.photos/seed/speaking1/200/100.jpg',
    creatorName: 'Speak Expert',
    creatorAvatarUrl: 'https://picsum.photos/seed/speak1/40/40.jpg',
  ),
];
