import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAccountSettings(),
            const SizedBox(height: 24),
            _buildAppSettings(),
            const SizedBox(height: 24),
            _buildSupportSettings(),
            const SizedBox(height: 24),
            _buildDangerZone(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(
        'Settings',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.darkText,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildAccountSettings() {
    return _buildSettingsSection(
      'Account Settings',
      [
        _buildSettingsItem(
          'Edit Profile',
          'Update your profile information',
          Icons.person_outline,
          () {},
        ),
        _buildSettingsItem(
          'Notification Settings',
          'Manage your notification preferences',
          Icons.notifications_outlined,
          () {},
        ),
        _buildSettingsItem(
          'Privacy Settings',
          'Control your privacy and data',
          Icons.lock_outline,
          () {},
        ),
        _buildSettingsItem(
          'Account Security',
          'Password and authentication settings',
          Icons.security,
          () {},
        ),
        _buildSettingsItem(
          'Payment Methods',
          'Manage your payment options',
          Icons.credit_card,
          () {},
        ),
      ],
    );
  }

  Widget _buildAppSettings() {
    return _buildSettingsSection(
      'App Settings',
      [
        _buildSettingsItem(
          'Appearance',
          'Theme, display, and accessibility',
          Icons.palette_outlined,
          () {},
        ),
        _buildSettingsItem(
          'Language',
          'Choose your preferred language',
          Icons.language_outlined,
          () {},
        ),
        _buildSettingsItem(
          'Data & Storage',
          'Manage your data and storage settings',
          Icons.storage_outlined,
          () {},
        ),
        _buildSettingsItem(
          'Default Apps',
          'Set your default applications',
          Icons.apps_outlined,
          () {},
        ),
      ],
    );
  }

  Widget _buildSupportSettings() {
    return _buildSettingsSection(
      'Support',
      [
        _buildSettingsItem(
          'Help & Support',
          'Get help and contact support',
          Icons.help_outline,
          () {},
        ),
        _buildSettingsItem(
          'About',
          'App version and legal information',
          Icons.info_outline,
          () {},
        ),
        _buildSettingsItem(
          'Send Feedback',
          'Help us improve the app',
          Icons.feedback_outlined,
          () {},
        ),
        _buildSettingsItem(
          'Report a Bug',
          'Report technical issues',
          Icons.bug_report_outlined,
          () {},
        ),
      ],
    );
  }

  Widget _buildDangerZone() {
    return _buildSettingsSection(
      'Danger Zone',
      [
        _buildSettingsItem(
          'Delete Account',
          'Permanently delete your account and data',
          Icons.delete_forever,
          () {},
          isDestructive: true,
        ),
      ],
      isDangerZone: true,
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items,
      {bool isDangerZone = false}) {
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDangerZone ? AppColors.accentRed : AppColors.darkText,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.accentRed.withOpacity(0.1)
              : AppColors.primaryBlurple.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isDestructive ? AppColors.accentRed : AppColors.primaryBlurple,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDestructive ? AppColors.accentRed : AppColors.darkText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.mediumText,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDestructive ? AppColors.accentRed : AppColors.lightText,
      ),
      onTap: onTap,
    );
  }
}
