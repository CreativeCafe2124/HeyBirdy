import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class HBAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HBAppBar({
    super.key,
    required this.title,
    required this.onClosePressed,
    this.onPublishPressed,
    required this.isPublishing,
  });

  final String title;
  final VoidCallback onClosePressed;
  final VoidCallback? onPublishPressed;
  final bool isPublishing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkText,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.close,
          color: AppColors.darkText,
        ),
        onPressed: onClosePressed,
      ),
      actions: [
        TextButton(
          onPressed: isPublishing ? null : onPublishPressed,
          child: isPublishing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlurple),
                  ),
                )
              : const Text(
                  'Publish',
                  style: TextStyle(
                    color: AppColors.primaryBlurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}