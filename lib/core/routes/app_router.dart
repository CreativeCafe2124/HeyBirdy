import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/screens/auth/loading_screen.dart';
import '../../presentation/screens/auth/offline_screen.dart';
import '../../presentation/screens/auth/get_started_screen.dart';
import '../../presentation/screens/auth/login.dart';
import '../../presentation/screens/auth/signup.dart';
import '../../presentation/screens/auth/otp.dart';
import '../../presentation/screens/home/home_feed_screen.dart';
import '../../presentation/screens/wallet/wallet_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/components/hb_tab_bar.dart';
import '../../providers/state_management.dart';
import '../../presentation/screens/explore/explore_screen.dart';
import '../../presentation/screens/create/create_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/create/upgrade_cta_screen.dart';

class AppRouter {
  static GoRouter buildRouter(AppRole? role, bool isAuthed, WidgetRef ref) {
    return GoRouter(
      initialLocation: '/loading',
      routes: <RouteBase>[
        GoRoute(
          path: '/loading',
          builder: (context, state) => const LoadingScreen(),
        ),
        GoRoute(
          path: '/offline',
          builder: (context, state) => const OfflineScreen(),
        ),
        GoRoute(
          path: '/get-started',
          builder: (context, state) => const GetStartedScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: '/otp',
          builder: (context, state) {
            final email = state.uri.queryParameters['email'] ?? '';
            return OtpVerificationScreen(email: email);
          },
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => Consumer(
            builder: (context, ref, child) {
              final tabIndex = ref.watch(currentTabProvider);
              return Scaffold(
                body: child,
                bottomNavigationBar: HBBottomNavBar(
                  currentIndex: tabIndex,
                  onTap: (index) {
                    ref.read(currentTabProvider.notifier).state = index;
                    const paths = [
                      '/home',
                      '/explore',
                      '/create',
                      '/wallet',
                      '/profile',
                    ];
                    context.go(paths[index]);
                  },
                ),
              );
            },
          ),
          routes: [
            GoRoute(
              path: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: 'explore',
              builder: (context, state) => const ExploreScreen(),
            ),
            GoRoute(
              path: 'create',
              builder: (context, state) => const CreateScreen(),
              routes: [
                GoRoute(
                  path: 'upgrade',
                  builder: (context, state) => const UpgradeCTAScreen(),
                ),
              ],
              redirect: (context, state) {
                final AppRole? currentRole = ref.watch(roleProvider);
                if (currentRole != AppRole.creator) {
                  return '/create/upgrade';
                }
                return null;
              },
            ),
            GoRoute(
              path: 'wallet',
              builder: (context, state) => const WalletScreen(),
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final bool onboardingComplete = ref.watch(onboardingCompleteProvider);

        if (!onboardingComplete &&
            state.fullPath != '/onboarding' &&
            state.fullPath != '/loading' &&
            state.fullPath != '/get-started' &&
            state.fullPath != '/login' &&
            state.fullPath != '/signup' &&
            state.fullPath != '/otp') {
          return '/onboarding';
        }

        return null;
      },
    );
  }
}
