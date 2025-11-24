// --- Data Models for Home Feed ---

/// Represents a piece of content (e.g., a recipe, a guide).
class ContentCard {
  final String id;
  final String title;
  final String imageUrl;
  final String creatorName;
  final String creatorAvatarUrl;
  final int likes;
  final int comments;
  final String contentType;
  final int views;
  final bool isLive;

  const ContentCard({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.creatorName,
    required this.creatorAvatarUrl,
    this.likes = 0,
    this.comments = 0,
    this.contentType = 'article',
    this.views = 0,
    this.isLive = false,
  });
}

/// Represents a popular or trending creator.
class Creator {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  const Creator({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
  });
}

// --- Mock Data ---

final List<Creator> mockPeopleLoving = [
  const Creator(
    id: '1',
    name: 'Fitness Rose',
    avatarUrl: 'https://picsum.photos/seed/fitness1/60/60.jpg',
    isOnline: true,
  ),
  const Creator(
    id: '2',
    name: 'Lifestyle Pro',
    avatarUrl: 'https://picsum.photos/seed/lifestyle1/60/60.jpg',
    isOnline: false,
  ),
  const Creator(
    id: '3',
    name: 'Bizam Arley',
    avatarUrl: 'https://picsum.photos/seed/bizam1/60/60.jpg',
    isOnline: true,
  ),
  const Creator(
    id: '4',
    name: 'Tech Guru',
    avatarUrl: 'https://picsum.photos/seed/tech1/60/60.jpg',
    isOnline: false,
  ),
  const Creator(
    id: '5',
    name: 'Foodie Queen',
    avatarUrl: 'https://picsum.photos/seed/food1/60/60.jpg',
    isOnline: true,
  ),
  const Creator(
    id: '6',
    name: 'Travel Expert',
    avatarUrl: 'https://picsum.photos/seed/travel1/60/60.jpg',
    isOnline: false,
  ),
  const Creator(
    id: '7',
    name: 'Music Master',
    avatarUrl: 'https://picsum.photos/seed/music1/60/60.jpg',
    isOnline: true,
  ),
  const Creator(
    id: '8',
    name: 'Art Designer',
    avatarUrl: 'https://picsum.photos/seed/art2/60/60.jpg',
    isOnline: false,
  ),
];

final List<ContentCard> mockForYou = [
  const ContentCard(
    id: '1',
    title: 'Healthy Smoothie Recipes - 5 Minute Breakfast',
    imageUrl: 'https://picsum.photos/seed/smoothie1/200/100.jpg',
    creatorName: 'Jane D.',
    creatorAvatarUrl: 'https://picsum.photos/seed/jane1/40/40.jpg',
    likes: 234,
    comments: 45,
    contentType: 'recipe',
    views: 1200,
    isLive: false,
  ),
  const ContentCard(
    id: '2',
    title: 'Financial Freedom Guide - Invest Smart',
    imageUrl: 'https://picsum.photos/seed/finance1/200/100.jpg',
    creatorName: 'Michael S.',
    creatorAvatarUrl: 'https://picsum.photos/seed/michael1/40/40.jpg',
    likes: 567,
    comments: 89,
    contentType: 'guide',
    views: 3400,
    isLive: false,
  ),
  const ContentCard(
    id: '3',
    title: 'Mastering Digital Art - Pro Techniques',
    imageUrl: 'https://picsum.photos/seed/art1/200/100.jpg',
    creatorName: 'Anya P.',
    creatorAvatarUrl: 'https://picsum.photos/seed/anya1/40/40.jpg',
    likes: 892,
    comments: 123,
    contentType: 'tutorial',
    views: 5600,
    isLive: true,
  ),
  const ContentCard(
    id: '4',
    title: 'Web Development Bootcamp - Full Stack',
    imageUrl: 'https://picsum.photos/seed/webdev1/200/100.jpg',
    creatorName: 'John K.',
    creatorAvatarUrl: 'https://picsum.photos/seed/john2/40/40.jpg',
    likes: 445,
    comments: 67,
    contentType: 'course',
    views: 2300,
    isLive: false,
  ),
  const ContentCard(
    id: '5',
    title: 'Yoga for Beginners - 30 Day Challenge',
    imageUrl: 'https://picsum.photos/seed/yoga1/200/100.jpg',
    creatorName: 'Sarah L.',
    creatorAvatarUrl: 'https://picsum.photos/seed/sarah1/40/40.jpg',
    likes: 321,
    comments: 54,
    contentType: 'fitness',
    views: 1800,
    isLive: false,
  ),
  const ContentCard(
    id: '6',
    title: 'Photography Masterclass - Capture Perfect Shots',
    imageUrl: 'https://picsum.photos/seed/photo1/200/100.jpg',
    creatorName: 'Emily J.',
    creatorAvatarUrl: 'https://picsum.photos/seed/emily1/40/40.jpg',
    likes: 756,
    comments: 98,
    contentType: 'course',
    views: 4200,
    isLive: false,
  ),
  const ContentCard(
    id: '7',
    title: 'Cooking Italian Cuisine - Authentic Recipes',
    imageUrl: 'https://picsum.photos/seed/cooking1/200/100.jpg',
    creatorName: 'Marco R.',
    creatorAvatarUrl: 'https://picsum.photos/seed/marco1/40/40.jpg',
    likes: 234,
    comments: 41,
    contentType: 'recipe',
    views: 1500,
    isLive: false,
  ),
  const ContentCard(
    id: '8',
    title: 'Language Learning - Speak Spanish in 30 Days',
    imageUrl: 'https://picsum.photos/seed/spanish1/200/100.jpg',
    creatorName: 'Carlos M.',
    creatorAvatarUrl: 'https://picsum.photos/seed/carlos1/40/40.jpg',
    likes: 189,
    comments: 32,
    contentType: 'course',
    views: 1100,
    isLive: false,
  ),
  const ContentCard(
    id: '9',
    title: 'Fitness Training - Build Muscle at Home',
    imageUrl: 'https://picsum.photos/seed/fitness2/200/100.jpg',
    creatorName: 'Alex T.',
    creatorAvatarUrl: 'https://picsum.photos/seed/alex1/40/40.jpg',
    likes: 412,
    comments: 76,
    contentType: 'fitness',
    views: 2800,
    isLive: false,
  ),
  const ContentCard(
    id: '10',
    title: 'Marketing Strategies - Grow Your Business',
    imageUrl: 'https://picsum.photos/seed/marketing1/200/100.jpg',
    creatorName: 'Lisa W.',
    creatorAvatarUrl: 'https://picsum.photos/seed/lisa1/40/40.jpg',
    likes: 523,
    comments: 87,
    contentType: 'guide',
    views: 3100,
    isLive: false,
  ),
  const ContentCard(
    id: '11',
    title: 'Meditation & Mindfulness - Reduce Stress',
    imageUrl: 'https://picsum.photos/seed/meditation1/200/100.jpg',
    creatorName: 'Zen Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/zen1/40/40.jpg',
    likes: 678,
    comments: 92,
    contentType: 'wellness',
    views: 3900,
    isLive: false,
  ),
  const ContentCard(
    id: '12',
    title: 'Gardening Tips - Grow Your Own Vegetables',
    imageUrl: 'https://picsum.photos/seed/garden1/200/100.jpg',
    creatorName: 'Green Thumb',
    creatorAvatarUrl: 'https://picsum.photos/seed/garden1/40/40.jpg',
    likes: 145,
    comments: 28,
    contentType: 'hobby',
    views: 900,
    isLive: false,
  ),
];

final List<Creator> mockTrendingCreators = [
  const Creator(
    id: 't1',
    name: 'Emily J.',
    avatarUrl: 'https://picsum.photos/seed/emily1/60/60.jpg'),
  const Creator(
    id: 't2',
    name: 'Mark T.', avatarUrl: 'https://picsum.photos/seed/mark1/60/60.jpg'),
  const Creator(
    id: 't3',
    name: 'John K.', avatarUrl: 'https://picsum.photos/seed/john1/60/60.jpg'),
  const Creator(
    id: 't4',
    name: 'Sarah L.',
    avatarUrl: 'https://picsum.photos/seed/sarah1/60/60.jpg'),
  const Creator(
    id: 't5',
    name: 'Alex R.', avatarUrl: 'https://picsum.photos/seed/alex2/60/60.jpg'),
  const Creator(
    id: 't6',
    name: 'Maria S.',
    avatarUrl: 'https://picsum.photos/seed/maria1/60/60.jpg'),
  const Creator(
    id: 't7',
    name: 'David L.',
    avatarUrl: 'https://picsum.photos/seed/david1/60/60.jpg'),
  const Creator(
    id: 't8',
    name: 'Sophie M.',
    avatarUrl: 'https://picsum.photos/seed/sophie1/60/60.jpg'),
  const Creator(
    id: 't9',
    name: 'Ryan K.', avatarUrl: 'https://picsum.photos/seed/ryan1/60/60.jpg'),
  const Creator(
    id: 't10',
    name: 'Nina P.', avatarUrl: 'https://picsum.photos/seed/nina1/60/60.jpg'),
];

// Additional mock data for different sections
final List<ContentCard> mockTrendingContent = [
  const ContentCard(
    id: 'tc1',
    title: 'AI Revolution - Future of Technology',
    imageUrl: 'https://picsum.photos/seed/ai1/200/100.jpg',
    creatorName: 'Tech Expert',
    creatorAvatarUrl: 'https://picsum.photos/seed/tech2/40/40.jpg',
  ),
  const ContentCard(
    id: 'tc2',
    title: 'Sustainable Living - Eco Friendly Tips',
    imageUrl: 'https://picsum.photos/seed/eco1/200/100.jpg',
    creatorName: 'Green Life',
    creatorAvatarUrl: 'https://picsum.photos/seed/eco1/40/40.jpg',
  ),
  const ContentCard(
    id: 'tc3',
    title: 'Cryptocurrency Guide - Bitcoin & Beyond',
    imageUrl: 'https://picsum.photos/seed/crypto1/200/100.jpg',
    creatorName: 'Crypto Guru',
    creatorAvatarUrl: 'https://picsum.photos/seed/crypto1/40/40.jpg',
  ),
  const ContentCard(
    id: 'tc4',
    title: 'Fashion Trends - 2024 Style Guide',
    imageUrl: 'https://picsum.photos/seed/fashion1/200/100.jpg',
    creatorName: 'Style Queen',
    creatorAvatarUrl: 'https://picsum.photos/seed/fashion1/40/40.jpg',
  ),
  const ContentCard(
    id: 'tc5',
    title: 'Pet Training - Raise Happy Dogs',
    imageUrl: 'https://picsum.photos/seed/pets1/200/100.jpg',
    creatorName: 'Pet Whisperer',
    creatorAvatarUrl: 'https://picsum.photos/seed/pets1/40/40.jpg',
  ),
  const ContentCard(
    id: 'tc6',
    title: 'Home Renovation - DIY Projects',
    imageUrl: 'https://picsum.photos/seed/home1/200/100.jpg',
    creatorName: 'DIY Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/diy1/40/40.jpg',
  ),
];

final List<ContentCard> mockNewContent = [
  const ContentCard(
    id: 'nc1',
    title: 'Podcast Production - Start Your Show',
    imageUrl: 'https://picsum.photos/seed/podcast1/200/100.jpg',
    creatorName: 'Audio Pro',
    creatorAvatarUrl: 'https://picsum.photos/seed/audio1/40/40.jpg',
  ),
  const ContentCard(
    id: 'nc2',
    title: 'Video Editing - Create Viral Content',
    imageUrl: 'https://picsum.photos/seed/video1/200/100.jpg',
    creatorName: 'Video King',
    creatorAvatarUrl: 'https://picsum.photos/seed/video1/40/40.jpg',
  ),
  const ContentCard(
    id: 'nc3',
    title: 'Social Media Marketing - Go Viral',
    imageUrl: 'https://picsum.photos/seed/social1/200/100.jpg',
    creatorName: 'Marketing Pro',
    creatorAvatarUrl: 'https://picsum.photos/seed/social1/40/40.jpg',
  ),
  const ContentCard(
    id: 'nc4',
    title: 'Writing Skills - Become Bestselling Author',
    imageUrl: 'https://picsum.photos/seed/writing1/200/100.jpg',
    creatorName: 'Write Master',
    creatorAvatarUrl: 'https://picsum.photos/seed/write1/40/40.jpg',
  ),
  const ContentCard(
    id: 'nc5',
    title: 'Public Speaking - Command the Room',
    imageUrl: 'https://picsum.photos/seed/speaking1/200/100.jpg',
    creatorName: 'Speak Expert',
    creatorAvatarUrl: 'https://picsum.photos/seed/speak1/40/40.jpg',
  ),
];
