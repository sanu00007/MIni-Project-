import 'package:farefinale/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  String _userPhotoUrl = '';

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      setState(() {
        _userEmail = _user!.email ?? 'Unknown Email';
      });

      try {
        final userQuery = await FirebaseFirestore.instance
            .collection('User')
            .where('email', isEqualTo: _userEmail)
            .limit(1)
            .get();

        if (userQuery.docs.isNotEmpty) {
          final userData = userQuery.docs.first.data();
          setState(() {
            _userName = userData['username'] ?? 'Unknown';
            _userPhotoUrl = userData['photoUrl'] ?? '';
          });
        } else {
          print('User document not found for email: $_userEmail');
        }
      } catch (e) {
        print('Error fetching user details: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _userPhotoUrl.isNotEmpty
                    ? NetworkImage(_userPhotoUrl)
                    : AssetImage('assets/images/profilepic.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Hello, $_userName!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $_userEmail',
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('About Us'),
              onTap: () {
                // Navigate to about us screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help Me'),
              onTap: () {
                // Navigate to help screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () async {
                // Perform sign-out and navigate to login screen
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              },
            ),
            const Divider(),
            Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Navigate to language selection screen
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
