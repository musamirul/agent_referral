import 'package:agent_referral/admin/views/screens/package_tap_screen/package_create_screen.dart';
import 'package:agent_referral/admin/views/screens/package_tap_screen/package_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPackageScreen extends StatefulWidget {
  const AdminPackageScreen({super.key});

  @override
  State<AdminPackageScreen> createState() => _AdminPackageScreenState();
}

class _AdminPackageScreenState extends State<AdminPackageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       appBar: AppBar(
         title: Padding(
           padding: const EdgeInsets.only(top: 25),
           child: Center(child: Text('Package Management', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
         ),
         backgroundColor: Colors.orange.shade400,
         elevation: 0,
         bottom: TabBar(
           tabs: [
             Tab(child: Text('Create Package',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1),),),
             Tab(child: Text('Package List',style: GoogleFonts.oswald(color: Colors.brown.shade600,fontWeight: FontWeight.bold,letterSpacing: 0.1,),),),
           ],
         ),
       ),
        body: TabBarView(children: [
          PackageCreateScreen(),
          PackageListScreen()
        ]),
      ),
    );
  }
}
