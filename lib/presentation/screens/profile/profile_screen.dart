import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../components/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(),
          _buildStatsCards(),
          _buildTabBar(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlurple, AppColors.accentOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),

              // Profile Info
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Johnson',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@sarahjohnson',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.mediumText,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'UI/UX Designer | Flutter Developer | Creating beautiful mobile experiences',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.mediumText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: HBPrimaryButton(
                  text: 'Edit Profile',
                  onPressed: () {
                    // TODO: Edit profile
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: HBSecondaryButton(
                  text: 'Share Profile',
                  onPressed: () {
                    // TODO: Share profile
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Followers',
              '12.5K',
              Icons.people_outline,
              AppColors.primaryBlurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Posts',
              '48',
              Icons.post_add_outlined,
              AppColors.accentOrange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Earnings',
              '\$2,450',
              Icons.attach_money_outlined,
              AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
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
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.mediumText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primaryBlurple,
        labelColor: AppColors.primaryBlurple,
        unselectedLabelColor: AppColors.mediumText,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: 'Posts'),
          Tab(text: 'Media'),
          Tab(text: 'Analytics'),
          Tab(text: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: 600, // Fixed height for tab content
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildMediaTab(),
          _buildAnalyticsTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSectionHeader('Recent Posts'),
          const SizedBox(height: 12),
          _buildPostsGrid(),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSectionHeader('Media Gallery'),
          const SizedBox(height: 12),
          _buildMediaGrid(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSectionHeader('Performance Analytics'),
          const SizedBox(height: 12),
          _buildAnalyticsCards(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSectionHeader('Account Settings'),
          const SizedBox(height: 12),
          _buildSettingsList(),
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

  Widget _buildPostsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: 6, // Mock data
      itemBuilder: (context, index) {
        return _buildPostCard(index);
      },
    );
  }

  Widget _buildPostCard(int index) {
    final posts = [
      {'title': 'Flutter Tips', 'likes': '234', 'comments': '12'},
      {'title': 'UI Design', 'likes': '189', 'comments': '8'},
      {'title': 'Mobile Dev', 'likes': '456', 'comments': '23'},
      {'title': 'Best Practices', 'likes': '321', 'comments': '15'},
      {'title': 'Code Review', 'likes': '278', 'comments': '19'},
      {'title': 'Tutorial', 'likes': '512', 'comments': '34'},
    ];

    final post = posts[index % posts.length];

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlurple, AppColors.accentOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image_outlined,
                color: AppColors.white,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: AppColors.mediumText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['likes'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumText,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.comment_outlined,
                      size: 16,
                      color: AppColors.mediumText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['comments'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumText,
                      ),
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

  Widget _buildMediaGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 9, // Mock data
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.image_outlined,
            color: AppColors.mediumText,
            size: 32,
          ),
        );
      },
    );
  }

  Widget _buildAnalyticsCards() {
    return Column(
      children: [
        _buildAnalyticsCard('Total Views', '45.2K', Icons.visibility_outlined,
            AppColors.primaryBlurple),
        const SizedBox(height: 12),
        _buildAnalyticsCard('Engagement Rate', '8.5%',
            Icons.trending_up_outlined, AppColors.accentGreen),
        const SizedBox(height: 12),
        _buildAnalyticsCard('Avg. Watch Time', '3:24',
            Icons.access_time_outlined, AppColors.accentOrange),
      ],
    );
  }

  Widget _buildAnalyticsCard(
      String title, String value, IconData icon, Color color) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Column(
      children: [
        _buildSettingsItem('Edit Profile', Icons.person_outline, () {}),
        _buildSettingsItem(
            'Notification Settings', Icons.notifications_outlined, () {}),
        _buildSettingsItem('Privacy Settings', Icons.lock_outline, () {}),
        _buildSettingsItem('Account Security', Icons.security, () {}),
        _buildSettingsItem('Payment Methods', Icons.credit_card, () {}),
        _buildSettingsItem('Help & Support', Icons.help_outline, () {}),
        _buildSettingsItem('About', Icons.info_outline, () {}),
        _buildSettingsItem('Sign Out', Icons.logout, () {},
            isDestructive: true),
      ],
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap,
      {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppColors.accentRed : AppColors.mediumText,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? AppColors.accentRed : AppColors.darkText,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDestructive ? AppColors.accentRed : AppColors.lightText,
        ),
        onTap: onTap,
      ),
    );
  }
}
