import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_colors.dart';
import '../state/auth_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/role_toggle.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  String _role = 'employee';
  bool _obscure = true;

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final ok = await auth.login(_identifier.text.trim(), _password.text);
    if (!mounted) return;
    if (!ok) {
      messenger.showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Login failed.')),
      );
    }
    // On success the AuthGate swaps to the correct home automatically.
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final busy = context.watch<AuthProvider>().busy;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(size: 96),
                    const SizedBox(height: 8),
                    Text(
                      'Pizza Striker',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _identifier,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Username or email'),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Enter your username or email' : null,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Enter your password' : null,
                    ),
                    const SizedBox(height: 18),
                    PrimaryButton(label: 'Login', loading: busy, onPressed: _submit),
                    const SizedBox(height: 16),
                    RoleToggle(value: _role, onChanged: (r) => setState(() => _role = r)),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: busy
                          ? null
                          : () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const RegisterScreen()),
                              ),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account?  ",
                          style: TextStyle(color: colors.textSecondary),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
