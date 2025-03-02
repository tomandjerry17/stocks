import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  
  void _updateProfile() async {
    try {
      await widget.user?.updateDisplayName(_nameController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile Updated")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user?.displayName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save Changes"),
              onPressed: _updateProfile,
            ),
          ],
        ),
      ),
    );
  }
}
