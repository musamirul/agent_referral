import 'package:agent_referral/firebase_options.dart';
import 'package:agent_referral/provider/referral_provider.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'agent/views/auth/agent_auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) {
        return ReferralProvider();
      },)
    ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agent Referral',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: AgentAuthScreen(),//LoginScreen(),//
      builder: EasyLoading.init(),
    );
  }
  
}