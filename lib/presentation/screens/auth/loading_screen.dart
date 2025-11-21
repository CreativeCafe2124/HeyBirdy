import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/connectivity_service.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  final String? message;
  final VoidCallback? onComplete;
  final Duration? loadingDuration;

  const LoadingScreen({
    super.key,
    this.message,
    this.onComplete,
    this.loadingDuration = const Duration(seconds: 3),
  });

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _startLoadingTimer();
  }

  void _startLoadingTimer() async {
    await Future.delayed(widget.loadingDuration ?? const Duration(seconds: 3));
    if (mounted) {
      if (!mounted) return;
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        if (!mounted) return;
        final connectivityService = ref.read(connectivityServiceProvider);
        final initialStatus =
            await connectivityService.checkInitialConnection();
        if (initialStatus == ConnectionStatus.disconnected) {
          if (!mounted) return;
          context.go('/offline');
        } else {
          if (!mounted) return;
          context.go('/get-started');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Explicitly setting white to match the image regardless of theme
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Using spacers to replicate the exact vertical positioning
              const Spacer(flex: 4),

              // 1. The Logo (Replicating the Blue/Purple Leaf)
              // If you have the actual PNG/SVG, use: Image.asset('assets/logo.png', height: 80)
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF8E2DE2), // Purple bottom
                      Color(0xFF4A00E0), // Deep Blue
                      Color(0xFF00C6FF), // Cyan/Blue top
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                // Icons.eco or Icons.spa looks closest to the leaf in the image
                child: const Icon(
                  Icons.eco_rounded,
                  size: 70,
                  color: Colors.white, // This color is ignored by the mask
                ),
              ),

              const SizedBox(height: 32),

              // 2. The Tagline Text
              const Text(
                'Learn. Earn. Grow.',
                style: TextStyle(
                  fontFamily: 'Roboto', // Or your app's main font
                  fontSize: 20,
                  color:
                      Color(0xFF2D3436), // Dark charcoal grey, not pure black
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 48),

              // 3. The Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3.5,
                  // Matches the blue/purple aesthetic
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                  backgroundColor:
                      const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  strokeCap: StrokeCap.round, // Softens the ends of the spinner
                ),
              ),

              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
