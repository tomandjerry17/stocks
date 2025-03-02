import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add the clientId here
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "515997175207-r353s1ja0tg2cgk6fqkrtlvdk65cdhvj.apps.googleusercontent.com", // Replace with actual Web Client ID
  );

  // Email & Password Sign-In
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");

      if (e.code == 'user-not-found') {
        throw Exception("No user found for this email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Incorrect password.");
      } else if (e.code == 'invalid-email') {
        throw Exception("Invalid email address.");
      } else {
        throw Exception("Login failed. Try again.");
      }
    } catch (e) {
      throw Exception("An unknown error occurred.");
    }
  }


  // Google Sign-In Function
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Google Sign-In error: ${e.message}");
      throw Exception("Google Sign-In failed. Try again.");
    } catch (e) {
      throw Exception("An unknown error occurred during Google Sign-In.");
    }
  }


  //  Sign Up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Sign-up error: ${e.message}");

      if (e.code == 'email-already-in-use') {
        throw Exception("This email is already in use.");
      } else if (e.code == 'weak-password') {
        throw Exception("Password should be at least 6 characters long.");
      } else if (e.code == 'invalid-email') {
        throw Exception("Invalid email address.");
      } else {
        throw Exception("Sign-up failed. Try again.");
      }
    } catch (e) {
      throw Exception("An unknown error occurred.");
    }
  }

  // Log Out
  Future<void> signOut() async {
  try {
    await _auth.signOut();
    await _googleSignIn.signOut(); // Ensure Google sign-out
  } catch (e) {
    print("Sign-out error: $e");
  }
}


}
