import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/connectivity_service.dart';

class OfflineScreen extends ConsumerStatefulWidget {
  const OfflineScreen({super.key});

  @override
  ConsumerState<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends ConsumerState<OfflineScreen> {
  bool _isChecking = false;

  Future<void> _retryConnection() async {
    setState(() => _isChecking = true);

    // minimal delay to show UI feedback
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final connectivityService = ref.read(connectivityServiceProvider);
    final status = await connectivityService.checkInitialConnection();

    if (!mounted) return;
    setState(() => _isChecking = false);

    if (status != ConnectionStatus.disconnected) {
      // If connection is back, go home (or back to previous route)
      context.go('/home');
    } else {
      // Optional: Show a snackbar if still offline
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Still offline. Please check your internet.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 4),

              // 1. The Light Blue Wifi Icon
              const Icon(
                Icons.wifi_rounded, // Rounded variant looks closer to design
                size: 60,
                color: Color(0xFF4FC3F7), // Light Cyan/Blue color from image
              ),

              const SizedBox(height: 24),

              // 2. The Message Text
              const Text(
                "You're offline. Retry?",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Color(0xFF2D3436), // Dark charcoal
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: 32),

              // 3. The Gradient Retry Button
              Container(
                width: 140,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), // Pill shape
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF8E2DE2), // Purple
                      Color(0xFF4A00E0), // Blue/Indigo
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A00E0).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isChecking ? null : _retryConnection,
                    borderRadius: BorderRadius.circular(24),
                    child: Center(
                      child: _isChecking
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
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
