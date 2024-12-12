import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GpMainScreen extends StatefulWidget {
  const GpMainScreen({super.key});

  @override
  State<GpMainScreen> createState() => _GpMainScreenState();
}

class _GpMainScreenState extends State<GpMainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Welcome to GP CLinic'),
            ElevatedButton(onPressed: () async{
              await _auth.signOut();
            }, child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }
}
