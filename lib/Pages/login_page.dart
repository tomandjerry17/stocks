import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'dashboard_page.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Function for Email/Password login
  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    User? user = await _authService.signInWithEmail(email, password);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SalesReportPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Check credentials.")),
      );
    }
  }

  // Function for Google Sign-In
  void _loginWithGoogle() async {
    User? user = await _authService.signInWithGoogle();

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SalesReportPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2E9), // Light mint green background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.asset('Assets/logo.png'),
                  ),
                  const Text(
                    'STOCK UP',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Email Input
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Input
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White text color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Google Sign-In Button
              GestureDetector(
                onTap: _loginWithGoogle,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png",
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Forgotten password
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgotten Password?',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Create account button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332), // Darker green
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
