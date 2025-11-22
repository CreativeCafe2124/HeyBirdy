import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../hb_section_header.dart';
import 'hb_text_input.dart';

class HBTitleInput extends StatelessWidget {
  const HBTitleInput({
    super.key,
    required this.controller,
    this.hintText,
  });

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HBSectionHeader(
          title: 'Title',
        ),
        const SizedBox(height: 8),
        HBTextInput(
          controller: controller,
          hintText: hintText ?? 'Enter a catchy title...',
        ),
      ],
    );
  }
}
