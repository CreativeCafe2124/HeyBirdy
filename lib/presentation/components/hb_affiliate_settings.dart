import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'hb_section_header.dart';
import 'hb_switch_tile.dart';
import '../forms/hb_text_input.dart';

class HBAffiliateSettings extends StatelessWidget {
  const HBAffiliateSettings({
    super.key,
    required this.enableAffiliate,
    required this.onEnableAffiliateChanged,
    required this.affiliateController,
  });

  final bool enableAffiliate;
  final ValueChanged<bool> onEnableAffiliateChanged;
  final TextEditingController affiliateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HBSectionHeader(
          title: 'Affiliate Marketing',
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
              HBSwitchTile(
                value: enableAffiliate,
                onChanged: onEnableAffiliateChanged,
                text: 'Enable Affiliate Links',
              ),
              if (enableAffiliate) ...[
                const SizedBox(height: 16),
                HBTextInput(
                  controller: affiliateController,
                  hintText: 'Enter affiliate link...',
                ),
                const SizedBox(height: 8),
                const Text(
                  'Earn commission when users purchase through your link',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.mediumText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
