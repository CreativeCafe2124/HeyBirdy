import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../../../core/constants/colors.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          _buildSearchAndFilter(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUpcomingEvents(),
                _buildLiveEvents(),
                _buildPastEvents(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Live Events',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.darkText,
          ),
          onPressed: () {
            // TODO: Show notifications
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primaryBlurple,
        labelColor: AppColors.primaryBlurple,
        unselectedLabelColor: AppColors.mediumText,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'Live'),
          Tab(text: 'Past'),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: HBSearchInput(
              hintText: 'Search events...',
              showFilterButton: false,
              showClearButton: true,
              onChanged: (value) {
                // TODO: Implement search
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBlurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.tune,
                color: AppColors.white,
              ),
              onPressed: () {
                // TODO: Show filter options
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Featured Event
          _buildSectionHeader('Featured Event'),
          const SizedBox(height: 12),
          _buildFeaturedEvent(),

          const SizedBox(height: 24),

          // All Upcoming Events
          _buildSectionHeader('All Upcoming Events'),
          const SizedBox(height: 12),
          _buildEventList(isUpcoming: true, isLive: false),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildLiveEvents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSectionHeader('Live Now'),
          const SizedBox(height: 12),
          _buildEventList(isUpcoming: false, isLive: true),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildPastEvents() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSectionHeader('Past Events'),
          const SizedBox(height: 12),
          _buildEventList(isUpcoming: false, isLive: false),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // TODO: View all
          },
          child: const Text(
            'See all',
            style: TextStyle(
              color: AppColors.primaryBlurple,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedEvent() {
    return HBEventCard(
      title: 'Flutter 3.0 Workshop',
      description:
          'Learn the latest Flutter features and best practices in this comprehensive workshop.',
      imageUrl: 'https://picsum.photos/seed/flutter-workshop/400/200.jpg',
      date: DateTime.now().add(const Duration(days: 7)),
      startTime: DateTime.now().add(const Duration(days: 7, hours: 18)),
      endTime: DateTime.now().add(const Duration(days: 7, hours: 20)),
      location: 'Online - Zoom',
      attendees: 245,
      maxAttendees: 500,
      isLive: false,
      isRegistered: false,
      isFeatured: true,
      price: '\$29',
      tags: const ['Flutter', 'Workshop', 'Development'],
      onTap: () {
        // TODO: Navigate to event details
      },
      onRegisterTap: () {
        // TODO: Handle registration
      },
      onShareTap: () {
        // TODO: Share event
      },
    );
  }

  Widget _buildEventList({required bool isUpcoming, required bool isLive}) {
    final events = isLive
        ? _getMockLiveEvents()
        : isUpcoming
            ? _getMockUpcomingEvents()
            : _getMockPastEvents();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: HBEventCard(
            title: events[index]['title'] as String,
            description: events[index]['description'] as String?,
            imageUrl: events[index]['imageUrl'] as String,
            date: events[index]['date'] as DateTime,
            startTime: events[index]['startTime'] as DateTime?,
            endTime: events[index]['endTime'] as DateTime?,
            location: events[index]['location'] as String?,
            attendees: events[index]['attendees'] as int?,
            maxAttendees: events[index]['maxAttendees'] as int?,
            isLive: events[index]['isLive'] as bool? ?? false,
            isRegistered: events[index]['isRegistered'] as bool? ?? false,
            isFeatured: false,
            price: events[index]['price'] as String?,
            tags: (events[index]['tags'] as List<String>?) ?? [],
            onTap: () {
              // TODO: Navigate to event details
            },
            onRegisterTap: () {
              // TODO: Handle registration
            },
            onShareTap: () {
              // TODO: Share event
            },
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _getMockLiveEvents() {
    return [
      {
        'title': 'UI/UX Design Live Session',
        'description':
            'Join us for a live design critique and feedback session.',
        'imageUrl': 'https://picsum.photos/seed/design-live/400/200.jpg',
        'date': DateTime.now(),
        'startTime': DateTime.now(),
        'endTime': DateTime.now().add(const Duration(hours: 2)),
        'location': 'Online - YouTube Live',
        'attendees': 1234,
        'maxAttendees': null,
        'isLive': true,
        'isRegistered': true,
        'price': 'Free',
        'tags': ['Design', 'Live', 'UI/UX'],
      },
      {
        'title': 'Mobile App Development Q&A',
        'description': 'Live Q&A session with experienced mobile developers.',
        'imageUrl': 'https://picsum.photos/seed/mobile-qa/400/200.jpg',
        'date': DateTime.now(),
        'startTime': DateTime.now().subtract(const Duration(minutes: 30)),
        'endTime': DateTime.now().add(const Duration(hours: 1, minutes: 30)),
        'location': 'Online - Discord',
        'attendees': 567,
        'maxAttendees': null,
        'isLive': true,
        'isRegistered': false,
        'price': 'Free',
        'tags': ['Mobile', 'Q&A', 'Development'],
      },
    ];
  }

  List<Map<String, dynamic>> _getMockUpcomingEvents() {
    return [
      {
        'title': 'React Native Masterclass',
        'description':
            'Advanced React Native techniques and performance optimization.',
        'imageUrl': 'https://picsum.photos/seed/react-native/400/200.jpg',
        'date': DateTime.now().add(const Duration(days: 3)),
        'startTime': DateTime.now().add(const Duration(days: 3, hours: 19)),
        'endTime': DateTime.now().add(const Duration(days: 3, hours: 21)),
        'location': 'Online - Teams',
        'attendees': 89,
        'maxAttendees': 200,
        'isLive': false,
        'isRegistered': false,
        'price': '\$49',
        'tags': ['React Native', 'Mobile', 'Advanced'],
      },
      {
        'title': 'Startup Pitch Practice',
        'description':
            'Practice your startup pitch with feedback from investors.',
        'imageUrl': 'https://picsum.photos/seed/startup-pitch/400/200.jpg',
        'date': DateTime.now().add(const Duration(days: 5)),
        'startTime': DateTime.now().add(const Duration(days: 5, hours: 17)),
        'endTime': DateTime.now().add(const Duration(days: 5, hours: 19)),
        'location': 'Hybrid - San Francisco',
        'attendees': 45,
        'maxAttendees': 100,
        'isLive': false,
        'isRegistered': true,
        'price': '\$25',
        'tags': ['Startup', 'Pitch', 'Business'],
      },
      {
        'title': 'Web Performance Workshop',
        'description':
            'Learn to optimize web applications for maximum performance.',
        'imageUrl': 'https://picsum.photos/seed/web-perf/400/200.jpg',
        'date': DateTime.now().add(const Duration(days: 10)),
        'startTime': DateTime.now().add(const Duration(days: 10, hours: 16)),
        'endTime': DateTime.now().add(const Duration(days: 10, hours: 18)),
        'location': 'Online - Zoom',
        'attendees': 156,
        'maxAttendees': 300,
        'isLive': false,
        'isRegistered': false,
        'price': '\$35',
        'tags': ['Web', 'Performance', 'Workshop'],
      },
    ];
  }

  List<Map<String, dynamic>> _getMockPastEvents() {
    return [
      {
        'title': 'Flutter State Management',
        'description': 'Deep dive into Flutter state management solutions.',
        'imageUrl': 'https://picsum.photos/seed/flutter-state/400/200.jpg',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'startTime':
            DateTime.now().subtract(const Duration(days: 2, hours: 18)),
        'endTime': DateTime.now().subtract(const Duration(days: 2, hours: 20)),
        'location': 'Online - Zoom',
        'attendees': 312,
        'maxAttendees': 500,
        'isLive': false,
        'isRegistered': true,
        'price': '\$29',
        'tags': ['Flutter', 'State Management', 'Recording'],
      },
      {
        'title': 'JavaScript Modern Features',
        'description':
            'Exploring modern JavaScript features and ES2023 updates.',
        'imageUrl': 'https://picsum.photos/seed/js-modern/400/200.jpg',
        'date': DateTime.now().subtract(const Duration(days: 7)),
        'startTime':
            DateTime.now().subtract(const Duration(days: 7, hours: 17)),
        'endTime': DateTime.now().subtract(const Duration(days: 7, hours: 19)),
        'location': 'Online - YouTube',
        'attendees': 1205,
        'maxAttendees': null,
        'isLive': false,
        'isRegistered': false,
        'price': 'Free',
        'tags': ['JavaScript', 'Modern', 'Recording'],
      },
      {
        'title': 'Database Design Principles',
        'description':
            'Fundamental principles of database design and architecture.',
        'imageUrl': 'https://picsum.photos/seed/database-design/400/200.jpg',
        'date': DateTime.now().subtract(const Duration(days: 14)),
        'startTime':
            DateTime.now().subtract(const Duration(days: 14, hours: 16)),
        'endTime': DateTime.now().subtract(const Duration(days: 14, hours: 18)),
        'location': 'Online - Teams',
        'attendees': 234,
        'maxAttendees': 400,
        'isLive': false,
        'isRegistered': true,
        'price': '\$39',
        'tags': ['Database', 'Design', 'Recording'],
      },
    ];
  }
}
