import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _currentBalance = 2450.75;

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
          _buildBalanceCard(),
          _buildQuickActions(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionList('all'),
                _buildTransactionList('income'),
                _buildTransactionList('expense'),
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
        'Wallet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.history_outlined,
            color: AppColors.darkText,
          ),
          onPressed: () {
            // TODO: Show transaction history
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.darkText,
          ),
          onPressed: () {
            // TODO: Show wallet settings
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlurple, AppColors.accentOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlurple.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Balance',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_currentBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 32,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBalanceItem(
                  'Income',
                  '\$1,234.50',
                  Icons.arrow_downward,
                  AppColors.accentGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBalanceItem(
                  'Expenses',
                  '\$783.75',
                  Icons.arrow_upward,
                  AppColors.accentRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(
      String label, String amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'Send',
              Icons.send_outlined,
              AppColors.accentGreen,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Send money - Coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Request',
              Icons.request_quote_outlined,
              AppColors.primaryBlurple,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request money - Coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              'Add',
              Icons.add_circle_outline,
              AppColors.accentOrange,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add money - Coming soon!')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
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
          Tab(text: 'All'),
          Tab(text: 'Income'),
          Tab(text: 'Expenses'),
        ],
      ),
    );
  }

  Widget _buildTransactionList(String type) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSectionHeader('Recent $type'),
          const SizedBox(height: 12),
          _buildTransactionItems(type),
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
            // TODO: View all transactions
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

  Widget _buildTransactionItems(String type) {
    final transactions = _getMockTransactions(type);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index]);
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';

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
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isIncome ? AppColors.accentGreen : AppColors.accentRed)
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction['icon'] as IconData,
              color: isIncome ? AppColors.accentGreen : AppColors.accentRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['description'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['date'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}\$${transaction['amount'] as String}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? AppColors.accentGreen : AppColors.accentRed,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  transaction['status'] as String,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.mediumText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockTransactions(String type) {
    final allTransactions = [
      {
        'title': 'Payment Received',
        'description': 'From John Doe',
        'amount': '250.00',
        'date': 'Today, 2:30 PM',
        'type': 'income',
        'icon': Icons.arrow_downward,
        'status': 'Completed',
      },
      {
        'type': 'expense',
        'icon': Icons.school,
        'status': 'completed',
      },
      {
        'title': 'Content Sale - Photography Masterclass',
        'description': 'From John Smith',
        'date': 'Today, 11:15 AM',
        'amount': '\$29.99',
        'type': 'income',
        'icon': Icons.camera_alt,
        'status': 'completed',
      },
      {
        'title': 'Affiliate Commission - Marketing Tools',
        'description': 'From Affiliate Partner',
        'date': 'Yesterday, 4:45 PM',
        'amount': '\$15.50',
        'type': 'income',
        'icon': Icons.link,
        'status': 'completed',
      },
      {
        'title': 'Platform Fee - Monthly Subscription',
        'description': 'HeyBirdy Platform',
        'date': 'Yesterday, 9:00 AM',
        'amount': '\$9.99',
        'type': 'expense',
        'icon': Icons.account_balance,
        'status': 'completed',
      },
      {
        'title': 'Content Sale - Yoga for Beginners',
        'description': 'From Sarah Johnson',
        'date': 'Dec 18, 3:20 PM',
        'amount': '\$19.99',
        'type': 'income',
        'icon': Icons.fitness_center,
        'status': 'completed',
      },
      {
        'title': 'Premium Feature - Analytics Pro',
        'description': 'HeyBirdy Premium',
        'date': 'Dec 18, 10:00 AM',
        'amount': '\$14.99',
        'type': 'expense',
        'icon': Icons.analytics,
        'status': 'completed',
      },
      {
        'title': 'Content Sale - Cooking Italian Cuisine',
        'description': 'From Maria Rodriguez',
        'date': 'Dec 17, 6:30 PM',
        'amount': '\$24.99',
        'type': 'income',
        'icon': Icons.restaurant,
        'status': 'completed',
      },
      {
        'title': 'Withdrawal - Bank Transfer',
        'description': 'To Bank Account ****1234',
        'date': 'Dec 17, 2:00 PM',
        'amount': '\$100.00',
        'type': 'expense',
        'icon': Icons.account_balance_wallet,
        'status': 'pending',
      },
      {
        'title': 'Content Sale - Web Development Bootcamp',
        'description': 'From David Lee',
        'date': 'Dec 16, 5:45 PM',
        'amount': '\$39.99',
        'type': 'income',
        'icon': Icons.code,
        'status': 'completed',
      },
      {
        'title': 'Content Sale - Language Learning Spanish',
        'description': 'From Alex Chen',
        'date': 'Dec 16, 1:30 PM',
        'amount': '\$34.99',
        'type': 'income',
        'icon': Icons.language,
        'status': 'completed',
      },
      {
        'title': 'Promotion - Featured Content',
        'description': 'HeyBirdy Promotion',
        'date': 'Dec 15, 11:00 AM',
        'amount': '\$19.99',
        'type': 'expense',
        'icon': Icons.trending_up,
        'status': 'completed',
      },
      {
        'title': 'Content Sale - Digital Marketing Guide',
        'description': 'From Emily Watson',
        'date': 'Dec 15, 9:15 AM',
        'amount': '\$27.99',
        'type': 'income',
        'icon': Icons.trending_up,
        'status': 'completed',
      },
    ];

    if (type == 'income') {
      return allTransactions.where((t) => t['type'] == 'income').toList();
    } else if (type == 'expense') {
      return allTransactions.where((t) => t['type'] == 'expense').toList();
    } else {
      return allTransactions;
    }
  }
}
