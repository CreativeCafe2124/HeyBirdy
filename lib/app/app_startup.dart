import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/state_management.dart';

Future<void> appStartup(Ref ref) async {
  await Supabase.initialize(
    url: 'https://your-real-supabase-url.supabase.co',
    anonKey: 'your-real-anon-key',
  );
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

  final prefs = await SharedPreferences.getInstance();
  // Stub for prototype demo
  await prefs.setBool('isAuthenticated', true);
  await prefs.setString('userRole', 'learner');
  await prefs.setBool('onboarding_complete', true);

  const isAuthed = true;
  const roleString = 'learner';
  final role =
      AppRole.values.firstWhere((r) => r.toString() == 'AppRole.$roleString');
  ref.read(isAuthenticatedProvider.notifier).state = isAuthed;
  ref.read(roleProvider.notifier).state = role;
}
