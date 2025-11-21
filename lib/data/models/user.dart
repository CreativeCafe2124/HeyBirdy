import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;
import '../../../providers/state_management.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? username;
  final String? avatarUrl;
  final AppRole role;
  final double earnings;
  final bool isApproved;
  final bool onboardingComplete;

  const User({
    required this.id,
    this.name,
    this.email,
    this.username,
    this.avatarUrl,
    this.role = AppRole.guest,
    this.earnings = 0.0,
    this.isApproved = false,
    this.onboardingComplete = false,
  });

  factory User.fromSupabase(supabase_flutter.User supabaseUser) {
    return User(
      id: supabaseUser.id,
      email: supabaseUser.email,
      name: supabaseUser.userMetadata?['name'],
      username: supabaseUser.userMetadata?['username'],
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      role: AppRole.guest, // Default role, will need to fetch from database or user_metadata
      onboardingComplete: supabaseUser.userMetadata?['onboarding_complete'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, name, email, username, avatarUrl, role, earnings, isApproved, onboardingComplete];
}
