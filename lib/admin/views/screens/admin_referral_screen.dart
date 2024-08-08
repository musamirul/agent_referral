import 'package:agent_referral/admin/views/screens/referral_tap_screen/referral_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReferralScreen extends StatelessWidget {
  const AdminReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Center(child: Text('Doctor Management', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
        ),
        backgroundColor: Colors.orange.shade400,
        elevation: 0,
        bottom: TabBar(
          tabs: [
            Tab(child: Text('New Request',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
            Tab(child: Text('All Request',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1,),),)
          ],
        ),
      ),
        body: TabBarView(children: [
          ReferralNewScreen(),
          ReferralNewScreen(),
        ]),
      ),
    );
  }
}
