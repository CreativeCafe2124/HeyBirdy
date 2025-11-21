import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_router.dart';
import 'providers/state_management.dart';
import 'core/theme/role_theme_adapter.dart' hide roleProvider, themeModeProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize app before running
  final container = ProviderContainer();
  await container.read(appStartupProvider.future);
  runApp(const ProviderScope(child: HeyBirdyApp()));
}

class HeyBirdyApp extends ConsumerWidget {
  const HeyBirdyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);
    final isAuthed = ref.watch(isAuthenticatedProvider);
    final router = AppRouter.buildRouter(role, isAuthed, ref);
    // ref.read(appStartupProvider); // init (fix provider later)
    final theme = ref.watch(roleThemeProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'HeyBirdy',
      theme: theme,
      darkTheme: theme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
