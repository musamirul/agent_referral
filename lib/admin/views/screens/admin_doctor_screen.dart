import 'package:agent_referral/admin/views/screens/doctor_tap_screen/doctor_create_screen.dart';
import 'package:agent_referral/admin/views/screens/doctor_tap_screen/doctor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDoctorScreen extends StatelessWidget {
  const AdminDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Center(child: Text('Doctor Management', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
        ),
        backgroundColor: Colors.orange.shade400,
        elevation: 0,
        bottom: TabBar(
          tabs: [
            Tab(child: Text('Create Doctor',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
            Tab(child: Text('Doctor List',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1,),),)
          ],
        ),
      ),
        body: TabBarView(children: [
          DoctorCreateScreen(),
          DoctorListScreen(),
        ]),
      ),
    );
  }
}
