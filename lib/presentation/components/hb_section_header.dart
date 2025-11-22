import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HBSectionHeader extends StatelessWidget {
  const HBSectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
      ),
    );
  }
}