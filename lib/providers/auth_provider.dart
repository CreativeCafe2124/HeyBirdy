import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;
import '../data/models/user.dart' as models;
import 'state_management.dart';
import '../services/referral_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, models.User?>(
    (ref) => AuthNotifier(ref.read(referralServiceProvider)));

class AuthNotifier extends StateNotifier<models.User?> {
  final ReferralService _referralService;

  AuthNotifier(this._referralService) : super(null) {
    _initAuthListener();
  }

  final _supabase = supabase_flutter.Supabase.instance.client;

  void _initAuthListener() {
    _supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;
      if (event == supabase_flutter.AuthChangeEvent.signedIn &&
          session != null) {
        _setCurrentUser(session.user);
      } else if (event == supabase_flutter.AuthChangeEvent.signedOut) {
        state = null;
      }
    });
  }

  Future<void> login(String email, String password) async {
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
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
      state = null;
    } catch (e) {
      // Consider using a logging framework instead of print in production
      // Example: log.severe('Logout error', e);
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String username,
      {String? referrerCode}) async {
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
        // Example: log.fine('Generated referral code for ${response.user!.id}: $newReferralCode');

        if (referrerCode != null && referrerCode.isNotEmpty) {
          await _referralService.trackReferral(referrerCode, response.user!.id);
        }
      }
    } catch (e) {
      // Consider using a logging framework instead of print in production
      // Example: log.severe('Sign Up error', e);
      rethrow;
    }
  }

  void _setCurrentUser(supabase_flutter.User? supabaseUser) {
    if (supabaseUser != null) {
      state = models.User(
        id: supabaseUser.id,
        email: supabaseUser.email ?? '',
        name: supabaseUser.userMetadata?['username'] ??
            'User', // Use 'username' from user_metadata
        role: AppRole.guest,
        onboardingComplete:
            supabaseUser.userMetadata?['onboarding_complete'] ?? false,
      );
    } else {
      state = null;
    }
  }
}
