import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorMainScreen extends StatelessWidget {
  const DoctorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(body: Center(child: ElevatedButton(child: Text('Sign Out'),onPressed: () {
      _auth.signOut();
    },)),);
  }
}
