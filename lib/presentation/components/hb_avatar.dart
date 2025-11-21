import 'package:flutter/material.dart';

class HBAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool online;

  const HBAvatar({super.key, this.imageUrl, this.size = 40, this.online = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null ? Icon(Icons.person, size: size * 0.6) : null,
        ),
        if (online)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: size * 0.22,
              height: size * 0.22,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

