import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

/// Wallet transaction card component
class HBWalletCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double amount;
  final String currencySymbol;
  final bool isIncome;
  final DateTime date;
  final String? category;
  final IconData? categoryIcon;
  final Color? categoryColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showDetails;

  const HBWalletCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.amount,
    this.currencySymbol = '\$',
    this.isIncome = false,
    required this.date,
    this.category,
    this.categoryIcon,
    this.categoryColor,
    this.onTap,
    this.onLongPress,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Category icon/avatar
                    if (categoryIcon != null) ...[
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (categoryColor ?? AppColors.primaryBlurple)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          categoryIcon,
                          color: categoryColor ?? AppColors.primaryBlurple,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],

                    // Transaction details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkText,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              subtitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.mediumText,
                              ),
                            ),
                          ],
                          if (showDetails) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (category != null) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.offWhite,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      category!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.mediumText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  _formatDate(date),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.lightText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${isIncome ? '+' : '-'}$currencySymbol${amount.abs().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isIncome
                                ? AppColors.accentGreen
                                : AppColors.accentRed,
                          ),
                        ),
                        if (showDetails) ...[
                          const SizedBox(height: 4),
                          Text(
                            isIncome ? 'Income' : 'Expense',
                            style: TextStyle(
                              fontSize: 12,
                              color: isIncome
                                  ? AppColors.accentGreen
                                  : AppColors.accentRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Wallet balance card
class HBWalletBalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;
  final String currencySymbol;
  final VoidCallback? onDetailsTap;
  final Widget? trailing;

  const HBWalletBalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
    this.currencySymbol = '\$',
    this.onDetailsTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlurple,
            AppColors.primaryBlurple.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlurple.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (trailing != null) trailing!,
                if (onDetailsTap != null)
                  GestureDetector(
                    onTap: onDetailsTap,
                    child: const Icon(
                      Icons.info_outline,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$currencySymbol${totalBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Income',
                    '+$currencySymbol${income.toStringAsFixed(2)}',
                    AppColors.white.withOpacity(0.8),
                    true,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Expenses',
                    '-$currencySymbol${expenses.toStringAsFixed(2)}',
                    AppColors.white.withOpacity(0.8),
                    false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, Color color, bool isIncome) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
