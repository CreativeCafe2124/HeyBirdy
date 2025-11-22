import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../../../core/constants/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
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
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGroupsTab(),
                _buildForumsTab(),
                _buildEventsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Community',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColors.darkText,
          ),
          onPressed: () {
            // TODO: Implement search functionality
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
          Tab(text: 'Groups'),
          Tab(text: 'Forums'),
          Tab(text: 'Events'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: HBSearchInput(
        hintText: 'Search communities...',
        showFilterButton: true,
        showClearButton: true,
        onChanged: (value) {
          // TODO: Implement search
        },
        onFilterTap: () {
          // TODO: Implement filter
        },
      ),
    );
  }

  Widget _buildGroupsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Featured Communities Section
          _buildSectionHeader('Featured Communities'),
          const SizedBox(height: 12),
          _buildFeaturedCommunities(),

          const SizedBox(height: 24),

          // All Communities Section
          _buildSectionHeader('All Communities'),
          const SizedBox(height: 12),
          _buildAllCommunities(),

          const SizedBox(height: 80), // Space for FAB
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

  Widget _buildFeaturedCommunities() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Mock data
        itemBuilder: (context, index) {
          return _buildFeaturedCommunityCard(index);
        },
      ),
    );
  }

  Widget _buildFeaturedCommunityCard(int index) {
    final communities = [
      {
        'name': 'Flutter Devs',
        'members': '12.5k',
        'color': AppColors.primaryBlurple
      },
      {
        'name': 'UI/UX Design',
        'members': '8.2k',
        'color': AppColors.accentOrange
      },
      {
        'name': 'Mobile Apps',
        'members': '15.7k',
        'color': AppColors.accentOrange
      },
    ];

    final community = communities[index % communities.length];

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: community['color'] as Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.group,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              community['name'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${community['members']} members',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Join',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCommunities() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Mock data
      itemBuilder: (context, index) {
        return _buildCommunityListItem(index);
      },
    );
  }

  Widget _buildCommunityListItem(int index) {
    final communities = [
      {'name': 'React Native', 'members': '9.8k', 'category': 'Development'},
      {'name': 'Product Design', 'members': '6.2k', 'category': 'Design'},
      {'name': 'Startup Founders', 'members': '4.5k', 'category': 'Business'},
      {'name': 'Machine Learning', 'members': '11.3k', 'category': 'AI/ML'},
      {
        'name': 'Web Development',
        'members': '18.1k',
        'category': 'Development'
      },
    ];

    final community = communities[index % communities.length];
    final isJoined = index % 2 == 0; // Mock join status

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryBlurple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.group,
              color: AppColors.primaryBlurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Community Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  community['name'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${community['category']} • ${community['members']} members',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumText,
                  ),
                ),
              ],
            ),
          ),

          // Join Button
          HBSecondaryButton(
            text: isJoined ? 'Joined' : 'Join',
            onPressed: () {
              // TODO: Toggle join status
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForumsTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.forum_outlined,
            size: 64,
            color: AppColors.lightText,
          ),
          SizedBox(height: 16),
          Text(
            'Forums Coming Soon',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.mediumText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_outlined,
            size: 64,
            color: AppColors.lightText,
          ),
          SizedBox(height: 16),
          Text(
            'Community Events Coming Soon',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.mediumText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // TODO: Create new community
      },
      backgroundColor: AppColors.primaryBlurple,
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}
