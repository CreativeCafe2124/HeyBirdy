import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../providers/state_management.dart';

class RoleGuard {
  static String? redirect(BuildContext context, GoRouterState state, AppRole? role, bool isAuthed) {
    final path = state.uri.path;

    // Auth guard
    if (!isAuthed && path != '/loading') {
      return '/loading';
    }
    if (isAuthed && path == '/loading') {
      return '/home';
    }

    // Role guards for MVP
    if (path.startsWith('/admin')) {
      if (role != AppRole.admin && role != AppRole.moderator) {
        return '/home';
      }
    }
    if (path.startsWith('/create')) {
      if (role != AppRole.creator && role != AppRole.admin && role != AppRole.moderator) {
        return '/home';
      }
    }
    if (path.startsWith('/affiliate') && role != AppRole.affiliate) {
        return '/home';
      }

    return null;
  }
}
