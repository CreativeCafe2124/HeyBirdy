import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'hb_section_header.dart';
import 'hb_switch_tile.dart';
import '../forms/hb_text_input.dart';

class HBPricingSettings extends StatelessWidget {
  const HBPricingSettings({
    super.key,
    required this.isFreeContent,
    required this.onFreeContentChanged,
    required this.priceController,
  });

  final bool isFreeContent;
  final ValueChanged<bool> onFreeContentChanged;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HBSectionHeader(
          title: 'Pricing',
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
                value: !isFreeContent,
                onChanged: (value) => onFreeContentChanged(!value),
                text: isFreeContent ? 'Free Content' : 'Paid Content',
              ),
              if (!isFreeContent) ...[
                const SizedBox(height: 16),
                HBTextInput(
                  controller: priceController,
                  hintText: 'Set price...',
                  keyboardType: TextInputType.number,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
