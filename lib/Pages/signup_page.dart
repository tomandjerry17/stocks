import 'package:flutter/material.dart';
import 'login_page.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  void _signUp() async {
    String firstName = firstNameController.text.trim();
    String surname = surnameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // **Validation**
    if (firstName.isEmpty || surname.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid email address")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters long")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    // **Create user account**
    User? user = await _authService.signUpWithEmail(email, password);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully! Please log in.")),
      );

      // Navigate to Login Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-up failed. Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7DA),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard on tap
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stock Up',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: surnameController,
                          decoration: InputDecoration(
                            hintText: 'Surname',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B5E20),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Color(0xFFFFA000),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Back to Log in',
                      style: TextStyle(
                        color: Color(0xFFFFA000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
