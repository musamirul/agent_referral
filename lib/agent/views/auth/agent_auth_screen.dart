import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../landing_screen.dart';

class AgentAuthScreen extends StatefulWidget {
  const AgentAuthScreen({super.key});

  @override
  State<AgentAuthScreen> createState() => _AgentAuthScreenState();
}

class _AgentAuthScreenState extends State<AgentAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        return LandingScreen();
      },
    );
  }
}
