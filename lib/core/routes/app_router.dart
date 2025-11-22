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
import '../../providers/state_management.dart';
import '../../presentation/components/components.dart';
import '../../presentation/screens/explore/explore_screen.dart';
import '../../presentation/screens/create/create_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/create/upgrade_cta_screen.dart';
import '../../presentation/screens/events/events_screen.dart';
import '../../presentation/screens/community/community_screen.dart';

class AppRouter {
  static GoRouter buildRouter(AppRole? role, bool isAuthed, WidgetRef ref) {
    return GoRouter(
      initialLocation: '/loading',
      routes: <RouteBase>[
        GoRoute(
            path: '/loading',
            builder: (context, state) => const LoadingScreen()),
        GoRoute(
            path: '/offline',
            builder: (context, state) => const OfflineScreen()),
        GoRoute(
            path: '/get-started',
            builder: (context, state) => const GetStartedScreen()),
        GoRoute(
            path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: '/signup', builder: (context, state) => const SignupScreen()),
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
            builder: (context, state) => const OnboardingScreen()),
        
        // Main app with bottom navigation
        ShellRoute(
          builder: (context, state, child) => Consumer(
            builder: (context, ref, child) {
              final location = state.uri.toString();
              int tabIndex = 0;
              
              // Determine tab index based on current path
              if (location.startsWith('/home')) {
                tabIndex = 0;
              } else if (location.startsWith('/explore')) {
                tabIndex = 1;
              } else if (location.startsWith('/community')) {
                tabIndex = 2;
              } else if (location.startsWith('/events')) {
                tabIndex = 3;
              } else if (location.startsWith('/profile')) {
                tabIndex = 4;
              }
              
              // Update tab provider if needed
              final currentTab = ref.read(currentTabProvider);
              if (currentTab != tabIndex) {
                ref.read(currentTabProvider.notifier).state = tabIndex;
              }
              
              return Scaffold(
                body: child,
                bottomNavigationBar: HBBottomNavBar(
                  currentIndex: tabIndex,
                  onTap: (index) {
                    ref.read(currentTabProvider.notifier).state = index;
                    const paths = [
                      '/home',
                      '/explore', 
                      '/community',
                      '/events',
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
                path: '/home',
                builder: (context, state) => const HomeScreen()),
            GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen()),
            GoRoute(
                path: '/community',
                builder: (context, state) => const CommunityScreen()),
            GoRoute(
              path: '/create',
              builder: (context, state) => const CreateScreen(),
              routes: [
                GoRoute(
                  path: 'upgrade',
                  builder: (context, state) => const UpgradeCTAScreen(),
                ),
              ],
              redirect: (context, state) {
                final AppRole? currentRole = ref.read(roleProvider);
                if (currentRole != AppRole.creator && !state.uri.toString().contains('/upgrade')) {
                  return '/create/upgrade';
                }
                return null;
              },
            ),
            GoRoute(
                path: '/events',
                builder: (context, state) => const EventsScreen()),
            GoRoute(
                path: '/wallet',
                builder: (context, state) => const WalletScreen()),
            GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen()),
          ],
        ),
      ],
    );
  }
}
