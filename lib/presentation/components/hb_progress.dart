import 'package:flutter/material.dart';

class HBProgress extends StatelessWidget {
  final double value; // 0..1
  const HBProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 8,
      ),
    );
  }
}

