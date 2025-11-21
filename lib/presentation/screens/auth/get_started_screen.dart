import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GetStartedScreen extends ConsumerWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top spacing to push text down slightly
              const Spacer(flex: 3),

              // 1. Headline Text
              const Text(
                'Your Growth\nStarts Here.',
                style: TextStyle(
                  fontFamily: 'Roboto', // Replace with specific font if needed
                  fontSize: 40,
                  height: 1.2, // Line height
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1F36), // Dark Navy/Black
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 16),

              // 2. Subtitle Text
              const Text(
                'Join a platform where people learn, creators earn, and everyone grows together.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF697386), // Slate Grey
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Pushes the button and footer to the bottom
              const Spacer(flex: 4),

              // 3. "Get Started" Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF5865F2), // Vibrant Blurple
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5865F2).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => context.go('/signup'),
                    child: const Center(
                      child: Text(
                        'Get Started',
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

              const SizedBox(height: 24),

              // 4. "Already have an account? Login"
              Center(
                child: GestureDetector(
                  onTap: () => context.go('/login'),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Color(0xFF697386),
                        fontSize: 15,
                        fontFamily: 'Roboto',
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Color(0xFF5865F2), // Matches button color
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 5. Footer Legal Links
              Center(
                child: Text(
                  'Terms of Use   |   Privacy Policy',
                  style: TextStyle(
                    color: Colors.grey[300], // Very light grey
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
