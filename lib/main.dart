import 'dart:io';

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
  // HttpOverrides.global = new MyHttpOverrides();
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

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true; }}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agent Referral',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: LoginScreen(),//AgentAuthScreen(),s
      builder: EasyLoading.init(),
    );
  }
  
}