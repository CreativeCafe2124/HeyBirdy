import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HBFilterChip extends StatelessWidget {
  const HBFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: AppColors.white,
      selectedColor: AppColors.primaryBlurple.withOpacity(0.1),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryBlurple : AppColors.darkText,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primaryBlurple : AppColors.borderColor,
      ),
    );
  }
}