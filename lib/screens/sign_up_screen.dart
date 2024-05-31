import 'package:final_project_haija/models/app_user.dart';
import 'package:final_project_haija/services/appuser_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _usernameErrorText = '';
  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _confirmPasswordErrorText = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _signUp() async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty) {
      setState(() {
        _usernameErrorText = 'Username tidak boleh kosong';
        _emailErrorText = '';
        _passwordErrorText = '';
        _confirmPasswordErrorText = '';
      });
      return;
    } else if (email.isEmpty || !email.contains('@')) {
      setState(() {
        _usernameErrorText = '';
        _emailErrorText = 'Email tidak boleh kosong atau harus menggunakan @';
        _passwordErrorText = '';
        _confirmPasswordErrorText = '';
      });
      return;
    } else if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _usernameErrorText = '';
        _emailErrorText = '';
        _passwordErrorText =
            'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\\\$%^&*(),.?":{}|<>]';
        _confirmPasswordErrorText = '';
      });
      return;
    } else if (password != confirmPassword) {
      setState(() {
        _usernameErrorText = '';
        _emailErrorText = '';
        _passwordErrorText = '';
        _confirmPasswordErrorText = 'Passwords do not match';
      });
      return;
    }

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        AppUserService.addNewAppUser(AppUser(username: username));
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/signin');
      }).catchError((error) {
        String errorText = error.toString();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorText)),
        );
      });

      setState(() {
        _usernameErrorText = '';
        _emailErrorText = '';
        _passwordErrorText = '';
        _confirmPasswordErrorText = '';
      });
    }
  }

  //TODO: 2. Membuat method dispose
  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Register text
              const Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Subtitle
              const Text('Please fill your details to sign up'),
              const SizedBox(height: 20),
              // Form
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  errorText:
                      _usernameErrorText.isNotEmpty ? _usernameErrorText : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText:
                      _emailErrorText.isNotEmpty ? _emailErrorText : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText:
                      _passwordErrorText.isNotEmpty ? _passwordErrorText : null,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: _confirmPasswordErrorText.isNotEmpty
                      ? _confirmPasswordErrorText
                      : null,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: _obscureConfirmPassword,
              ),
              const SizedBox(height: 20),
              // Register button
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
