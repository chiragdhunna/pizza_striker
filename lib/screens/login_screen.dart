import 'package:flutter/material.dart';
import 'package:pizza_striker/db_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  String userType = 'employee'; // default value

  final data = DBHelper().getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: userType,
              onChanged: (String? newValue) {
                setState(() {
                  userType = newValue!;
                });
              },
              items: <String>['employee', 'admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () => _login(),
              child: const Text('Login'),
            ),
            Text('Hi'),
          ],
        ),
      ),
    );
  }

  void _login() {
    // Here you would usually integrate with backend to validate
    Navigator.of(context)
        .pushReplacementNamed(userType == 'employee' ? '/dashboard' : '/admin');
  }
}
