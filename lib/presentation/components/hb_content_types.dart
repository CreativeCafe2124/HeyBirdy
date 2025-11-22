import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'hb_section_header.dart';
import 'hb_filter_chip.dart';

class HBContentTypes extends StatelessWidget {
  const HBContentTypes({
    super.key,
    required this.types,
    required this.currentTypeIndex,
    required this.onTypeSelected,
  });

  final List<String> types;
  final int currentTypeIndex;
  final ValueChanged<int> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HBSectionHeader(
          title: 'Content Type',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: types.length,
            itemBuilder: (context, index) {
              final isSelected = currentTypeIndex == index;
              return Container(
                margin: const EdgeInsets.only(right: 12),
                child: HBFilterChip(
                  label: types[index],
                  isSelected: isSelected,
                  onSelected: (selected) {
                    onTypeSelected(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
