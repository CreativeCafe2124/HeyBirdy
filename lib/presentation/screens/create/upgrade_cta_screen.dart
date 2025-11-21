import 'package:flutter/material.dart';

class UpgradeCTAScreen extends StatelessWidget {
  const UpgradeCTAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Become a Creator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.workspace_premium, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Unlock your potential! Become a Creator to share your content.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Unlock your potential! Become a Creator to share your content.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Join our community of creators and start earning today!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // Upgrade flow: navigate to creator onboarding
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/creator-onboarding');
              },
              child: const Text('Learn More & Upgrade'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement navigation to an upgrade/onboarding for creators
              },
              child: const Text('Learn More & Upgrade'),
            ),
          ],
        ),
      ),
    );
  }
}
