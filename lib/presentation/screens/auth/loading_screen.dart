import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

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
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        // Simplified: always go to home after loading
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.go('/home');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 4),

              // 1. The Logo (Updated gradient to match Figma)
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColors.primaryBlurple, // Updated to brand color
                      Color(0xFF8E2DE2), // Purple
                      Color(0xFF4A00E0), // Deep Blue
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: const Icon(
                  Icons.eco_rounded,
                  size: 70,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              // 2. The Tagline Text (Updated to use theme)
              Text(
                'Learn. Earn. Grow.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 48),

              // 3. The Loading Indicator (Updated colors)
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3.5,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlurple),
                  backgroundColor: AppColors.primaryBlurple.withValues(alpha: 0.1),
                  strokeCap: StrokeCap.round,
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
