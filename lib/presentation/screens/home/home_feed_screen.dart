import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:heybirdy/presentation/components/home_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/state_management.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine the greeting based on the time of day (basic example)
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) return 'Good morning ☀️';
      if (hour < 17) return 'Good afternoon 🌤️';
      return 'Good evening 🌙';
    }

    final feedItems = ref.watch(feedProvider);
    final trendingCreators = ref.watch(trendingCreatorsProvider);

    return Scaffold(
      // --- Content Area ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Greeting (e.g., "Good morning ☀️")
              Text(
                getGreeting(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),

              // --- Section 1: People are loving today ---
              const Text(
                'People are loving today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180, // Height needed for the cards (Image + Text)
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: feedItems.length,
                  itemBuilder: (context, index) {
                    return ContentCard(content: feedItems[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),

              // --- Section 2: For you ---
              const Text(
                'For you',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180, // Height needed for the horizontal cards
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: feedItems.length,
                  itemBuilder: (context, index) {
                    return ContentCard.horizontal(content: feedItems[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),

              // --- Section 3: Trending Creators CTA ---
              const Text(
                'Trending creators',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              GenerateLinkBanner(trendingCreators: trendingCreators),

              const SizedBox(
                  height: 80), // Extra space for bottom nav bar clearance
            ],
          ),
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.08 * 255).round()),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors
              .transparent, // Make it transparent to show the container's decoration
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          currentIndex: 0, // Home is selected
          onTap: (index) {
            // Navigation logic (example using GoRouter)
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 4:
                context.go('/profile'); // Placeholder route
                break;
              // Add cases for Explore, Community, Events
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
