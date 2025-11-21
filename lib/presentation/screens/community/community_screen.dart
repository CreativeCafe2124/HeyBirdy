import 'package:flutter/material.dart';



class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HeyBirdy — Community')),
      body: const Center(child: Text('Groups & Forums')),
    );
  }
}
