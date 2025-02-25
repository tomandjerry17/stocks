import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // **1. Sign in with Email & Password**
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // **2. Sign Up with Email & Password**
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // **3. Sign Out**
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
