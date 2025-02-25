import 'package:flutter/material.dart';
import 'Pages/login_page.dart';
//import 'Pages/dashboard_page.dart';
//import 'Pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold();
}
