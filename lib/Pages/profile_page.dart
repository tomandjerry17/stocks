import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser?.delete();
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting account: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : AssetImage('assets/default_avatar.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(user?.displayName ?? "No Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user?.email ?? "No Email", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.edit),
              label: Text("Edit Profile"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(user: user)));
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.delete, color: Colors.red),
              label: Text("Delete Account", style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => _deleteAccount(context),
            ),
          ],
        ),
      ),
    );
  }
}
