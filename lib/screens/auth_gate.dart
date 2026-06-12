import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_provider.dart';
import '../widgets/async_views.dart';
import 'admin/admin_shell.dart';
import 'employee/employee_shell.dart';
import 'login_screen.dart';

/// Decides what to show based on auth state: loading, login, or a role shell.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    switch (auth.status) {
      case AuthStatus.unknown:
        return const Scaffold(body: LoadingView(message: 'Loading…'));
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      case AuthStatus.authenticated:
        return auth.isAdmin ? const AdminShell() : const EmployeeShell();
    }
  }
}
