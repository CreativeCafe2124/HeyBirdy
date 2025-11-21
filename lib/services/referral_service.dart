import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ReferralService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final Uuid _uuid = const Uuid();

  Future<String> generateReferralCode(String userId) async {
    final String code = _uuid.v4().substring(0, 8); // Generate a short unique code
    await _supabase.from('referral_codes').insert({
      'user_id': userId,
      'code': code,
      'created_at': DateTime.now().toIso8601String(),
    });
    return code;
  }

  Future<void> trackReferral(String referrerCode, String referredUserId) async {
    final response = await _supabase
        .from('referral_codes')
        .select('user_id')
        .eq('code', referrerCode)
        .single();

    if (response.isNotEmpty) {
      final String referrerId = response['user_id'];
      await _supabase.from('referrals').insert({
        'referrer_id': referrerId,
        'referred_user_id': referredUserId,
        'referred_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<String?> getReferralCodeForUser(String userId) async {
    final response = await _supabase
        .from('referral_codes')
        .select('code')
        .eq('user_id', userId)
        .single();
    return response.isNotEmpty ? response['code'] : null;
  }
}