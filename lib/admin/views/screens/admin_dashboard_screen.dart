import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(icon: Icon(Icons.logout), onPressed: () {
        _auth.signOut();
      },),
    ),body: Center(child: Text('Admin Dashboard Screen')),);
  }
}
