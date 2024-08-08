import 'package:agent_referral/doctor/views/screens/referral_tap_screen/referral_get_screen.dart';
import 'package:agent_referral/doctor/views/screens/referral_tap_screen/referral_history_screen.dart';
import 'package:agent_referral/doctor/views/screens/referral_tap_screen/referral_request.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorReferralScreen extends StatelessWidget {
  const DoctorReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(child: Text('Referral Requested', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
            ),
            backgroundColor: Colors.orange.shade400,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(child: Text('Requested',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
              Tab(child: Text('Current',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
              Tab(child: Text('History',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
            ]),
          ),
          body: TabBarView(children: [
            ReferralRequestScreen(),
            ReferralGetScreen(),
            ReferralHistoryScreen(),
          ]),
        ));
  }
}
