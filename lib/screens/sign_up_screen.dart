import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pizza_striker/db_helper.dart';
import 'package:pizza_striker/logic/older_models/old_user_model.dart';
import 'package:pizza_striker/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerFullName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  final db = DBHelper();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // For role selection
  String _selectedRole = 'Admin'; // Default selected role

  final Logger _logger = Logger();

  @override
  void initState() {
    db.initDb().then((value) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Colors based on theme mode
    final backgroundColor = isDarkMode
        ? const Color(0xFF1A1F2E) // Dark navy background
        : Colors.white;

    final inputFieldColor = isDarkMode
        ? const Color(0xFF252A3A) // Darker input field in dark mode
        : const Color(0xFFF8F9FD); // Light gray in light mode

    const buttonColor = Color(0xFFEE5730); // Orange button for both themes

    final textColor = isDarkMode ? Colors.white : Colors.black87;

    final hintTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(0), // or try 1 if 0 causes layout issues
        child: AppBar(
          backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
          shadowColor: Colors.transparent, // eliminate elevation shadow
          surfaceTintColor: Colors.transparent, // for Material 3 themes
          elevation: 0, // no shadow
          toolbarHeight: 0, // removes any toolbar render space
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo
                Center(
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset(isDarkMode
                        ? 'assets/pizza_striker_logo_dark.png'
                        : 'assets/pizza_striker_logo_light.png'),
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 30),

                // Full name field
                TextField(
                  controller: _controllerFullName,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: "Full name",
                    hintStyle: TextStyle(color: hintTextColor),
                    filled: true,
                    fillColor: inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                  onEditingComplete: () => _focusNodeEmail.requestFocus(),
                ),
                const SizedBox(height: 16),

                // Email field
                TextField(
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                  style: TextStyle(color: textColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: hintTextColor),
                    filled: true,
                    fillColor: inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: _controllerPassword,
                  focusNode: _focusNodePassword,
                  style: TextStyle(color: textColor),
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: hintTextColor),
                    filled: true,
                    fillColor: inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: hintTextColor,
                      ),
                    ),
                  ),
                  onEditingComplete: () =>
                      _focusNodeConfirmPassword.requestFocus(),
                ),
                const SizedBox(height: 16),

                // Confirm password field
                TextField(
                  controller: _controllerConfirmPassword,
                  focusNode: _focusNodeConfirmPassword,
                  style: TextStyle(color: textColor),
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: hintTextColor),
                    filled: true,
                    fillColor: inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: hintTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Role selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 8),
                      child: Text(
                        "Role",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRole = 'Admin';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _selectedRole == 'Admin'
                                    ? buttonColor.withOpacity(0.2)
                                    : inputFieldColor,
                                borderRadius: BorderRadius.circular(10),
                                border: _selectedRole == 'Admin'
                                    ? Border.all(color: buttonColor, width: 2)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "Admin",
                                  style: TextStyle(
                                    color: _selectedRole == 'Admin'
                                        ? buttonColor
                                        : textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRole = 'Employee';
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _selectedRole == 'Employee'
                                    ? buttonColor.withOpacity(0.2)
                                    : inputFieldColor,
                                borderRadius: BorderRadius.circular(10),
                                border: _selectedRole == 'Employee'
                                    ? Border.all(color: buttonColor, width: 2)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "Employee",
                                  style: TextStyle(
                                    color: _selectedRole == 'Employee'
                                        ? buttonColor
                                        : textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Register button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: textColor),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegistration() {
    // Basic validation
    if (_controllerFullName.text.isEmpty) {
      _showErrorSnackBar('Please enter your full name');
      return;
    }

    if (_controllerEmail.text.isEmpty ||
        !(_controllerEmail.text.contains('@') &&
            _controllerEmail.text.contains('.'))) {
      _showErrorSnackBar('Please enter a valid email address');
      return;
    }

    if (_controllerPassword.text.isEmpty ||
        _controllerPassword.text.length < 8) {
      _showErrorSnackBar('Password must be at least 8 characters');
      return;
    }

    if (_controllerPassword.text != _controllerConfirmPassword.text) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }

    // Registration success
    _logger.i('Registering user: ${_controllerEmail.text} as $_selectedRole');

    if (_selectedRole == 'Employee') {
      final userData = User(
        name: _controllerFullName.text,
        strikes: 0,
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        username: _controllerFullName.text,
      );

      db.createUser(userData);
    } else {
      // Handle admin registration
      // Implementation pending for admin data model
      _logger.i('Admin registration logic to be implemented');
    }

    _showSuccessSnackBar('Registration successful!');

    // Navigate to login screen
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }
}
