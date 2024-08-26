import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_history_screen.dart';
import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_pending_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientRegisteredListScreen extends StatelessWidget {
  const PatientRegisteredListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Center(child: Text('Registered Referral', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
        ),
        backgroundColor: Colors.orange.shade400,
        elevation: 0,
        bottom: TabBar(tabs: [
          Tab(child: Text('Pending Approval',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
          Tab(child: Text('Completed',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
        ]),
      ),
      body: TabBarView(children: [
        PatientPendingScreen(),
        PatientHistoryScreen(),
      ]),
    ));
  }
}
