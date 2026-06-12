import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_colors.dart';
import '../state/auth_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/role_toggle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  String _role = 'employee';
  bool _obscure = true;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);

    if (_role == 'admin') {
      messenger.showSnackBar(const SnackBar(
        content: Text('Admin accounts are created by an existing admin — '
            'registering you as an employee.'),
      ));
    }

    final ok = await auth.register(
      email: _email.text.trim(),
      username: _username.text.trim(),
      password: _password.text,
      fullName: _fullName.text.trim(),
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(); // AuthGate now shows the employee home.
    } else {
      messenger.showSnackBar(SnackBar(content: Text(auth.error ?? 'Registration failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final busy = context.watch<AuthProvider>().busy;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(size: 80),
                    const SizedBox(height: 8),
                    Text(
                      'Create account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _fullName,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Full name'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter your email';
                        if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _username,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Username'),
                      validator: (v) => (v == null || v.trim().length < 3)
                          ? 'At least 3 characters'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.length < 6) ? 'At least 6 characters' : null,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Role',
                          style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 8),
                    RoleToggle(value: _role, onChanged: (r) => setState(() => _role = r)),
                    const SizedBox(height: 20),
                    PrimaryButton(label: 'Register', loading: busy, onPressed: _submit),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: busy ? null : () => Navigator.of(context).pop(),
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account?  ',
                          style: TextStyle(color: colors.textSecondary),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: colors.primary, fontWeight: FontWeight.w700),
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
