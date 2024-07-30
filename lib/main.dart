import 'package:agent_referral/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'agent/views/auth/agent_auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agent Referral',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: AgentAuthScreen(),
    );
  }
  
}