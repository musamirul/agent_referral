import 'package:agent_referral/agent/views/screens/hospital_tap_screen/doctor_info_screen.dart';
import 'package:agent_referral/agent/views/screens/hospital_tap_screen/package_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalInfoScreen extends StatefulWidget {
  const HospitalInfoScreen({super.key});

  @override
  State<HospitalInfoScreen> createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(child: Text('Hospital Info', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
            ),
            backgroundColor: Colors.orange.shade400,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(child: Text('Package',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
              Tab(child: Text('Doctor',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),)
            ]),
          ),
          body: TabBarView(children: [
            PackageInfoScreen(),
            DoctorInfoScreen(),
          ]),
        ));
  }
}
