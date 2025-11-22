import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/state_management.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  // List of available topics based on the image
  final List<String> _topics = [
    'Fitness',
    'Business',
    'Beauty',
    'Lifestyle',
    'Finance',
    'Personal Growth',
  ];

  // Track selected items
  final Set<String> _selectedTopics = {};

  void _toggleTopic(String topic) {
    setState(() {
      if (_selectedTopics.contains(topic)) {
        _selectedTopics.remove(topic);
      } else {
        _selectedTopics.add(topic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading:
            false, // No back button shown in this specific screen mock
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 1. Headline
              const Text(
                'Tell us what inspires\nyou.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1F36),
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 12),

              // 2. Subtitle
              const Text(
                'We use this to personalize your\nexperience.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Color(0xFF697386), // Slate Grey
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // 3. Grid of Options
              Expanded(
                child: GridView.builder(
                  itemCount: _topics.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.8, // Adjust ratio to match button shape
                  ),
                  itemBuilder: (context, index) {
                    final topic = _topics[index];
                    final isSelected = _selectedTopics.contains(topic);

                    return GestureDetector(
                      onTap: () => _toggleTopic(topic),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(
                                  0xFF5865F2) // Selected: Blurple fill
                              : Colors.white, // Unselected: White fill
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5865F2)
                                : const Color(
                                    0xFF9CA3AF), // Unselected: Grey border
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF5865F2)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            topic,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(
                                      0xFF9CA3AF), // Grey text when unselected
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 4. Bottom Section
              Center(
                child: Text(
                  'Pick at least one-you can change later.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 5. Continue Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // Gradient similar to previous screens
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C63FF),
                      Color(0xFF9D50BB),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      if (_selectedTopics.isNotEmpty) {
                        ref.read(selectedInterestsProvider.notifier).state = _selectedTopics;

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('onboarding_complete', true);
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          context.go('/home');
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please pick at least one topic.')),
                        );
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
