import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'hb_section_header.dart';
import 'hb_publishing_option_tile.dart';

class HBPublishingOptions extends StatelessWidget {
  const HBPublishingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HBSectionHeader(
          title: 'Publishing Options',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            children: [
              HBPublishingOptionTile(
                title: 'Publish immediately',
                description: 'Content goes live right away',
                icon: Icons.publish,
                isSelected: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Publishing options - Coming soon!')),
                  );
                },
              ),
              const Divider(color: AppColors.borderColor),
              HBPublishingOptionTile(
                title: 'Schedule for later',
                description: 'Set a specific publish time',
                icon: Icons.schedule,
                isSelected: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Publishing options - Coming soon!')),
                  );
                },
              ),
              const Divider(color: AppColors.borderColor),
              HBPublishingOptionTile(
                title: 'Save as draft',
                description: 'Publish later when ready',
                icon: Icons.save_alt,
                isSelected: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Publishing options - Coming soon!')),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
