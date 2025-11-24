import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user.dart' as models;

final authProvider = StateNotifierProvider<AuthNotifier, models.User?>(
    (ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<models.User?> {

  AuthNotifier() : super(null) {
    // Disable auth listener for UI-only development
  }

  // Supabase integration disabled for UI-only development

  Future<void> login(String email, String password) async {
    // Disabled for UI-only development
    /*
    try {
      final supabase_flutter.AuthResponse response =
          await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _setCurrentUser(response.user);
    } catch (e) {
      // Consider using a logging framework instead of print in production
      // Example: log.severe('Login error', e);
      rethrow;
    }
    */
  }

  Future<void> logout() async {
    // Disabled for UI-only development
    /*
    try {
      await _supabase.auth.signOut();
      state = null;
    } catch (e) {
      // Consider using a logging framework instead of print in production
      // Example: log.severe('Logout error', e);
      rethrow;
    }
    */
  }

  Future<void> signUp(String email, String password, String username,
      {String? referrerCode}) async {
    // Disabled for UI-only development
    /*
    try {
      final supabase_flutter.AuthResponse response =
          await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );
      if (response.user != null) {
        _setCurrentUser(response.user);
        await _referralService.generateReferralCode(response.user!.id);
        // Consider using a logging framework instead of print in production
        // Example: log.info('User signed up: ${response.user!.id}');
      }
    } catch (e) {
      // Consider using a logging framework instead of print in production
      // Example: log.severe('Signup error', e);
      rethrow;
    }
    */
  }

}
