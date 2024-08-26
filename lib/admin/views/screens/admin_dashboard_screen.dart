import 'package:agent_referral/admin/views/screens/admin_doctor_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_feedback_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_package_screen.dart';
import 'package:agent_referral/admin/views/screens/agent_registered_screen.dart';
import 'package:agent_referral/admin/views/screens/user_tap_screen/user_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Icon> _icon = [
      Icon(Icons.image, size: 70, color: Colors.yellow.shade900),
      Icon(Icons.local_hospital, size: 70, color: Colors.yellow.shade900),
      Icon(Icons.list, size: 70, color: Colors.yellow.shade900),
      Icon(Icons.feedback_rounded, size: 70, color: Colors.yellow.shade900),
    ];

    List<String> _itemName = [
      'Package',
      'Doctor',
      'Users',
      'Feedback',
    ];

    List<Widget> _pages = [
      AdminPackageScreen(),
      AdminDoctorScreen(),
      AgentRegisteredScreen(),
      AdminFeedbackScreen(),
    ];

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(child: Text('Dashboard', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
        ),
        backgroundColor: Colors.orange.shade400,
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () async{
        //     await _auth.signOut();
        //   },
        // ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // DrawerHeader(child: Text('Hi Admin')),
                UserAccountsDrawerHeader(decoration: BoxDecoration(color: Colors.orange.shade700),accountName: Text('Hi Admin'), accountEmail: Text(_auth.currentUser!.email.toString()),),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: ListTile(leading: Icon(Icons.home,),title: Text('Home')),),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: ListTile(leading: Icon(Icons.info,),title: Text('About')),),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: ListTile(leading: Icon(Icons.settings,),title: Text('Settings')),)
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout,),title: Text('Logout'),onTap: () async{
                await _auth.signOut();
              },
            ),)
          ],
        ),
      ),

      body: GridView.builder(
        itemCount: _itemName.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  print("Navigating to AdminDoctorScreen");
                  return _pages[index];
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.yellow.shade300, Colors.orange.shade200],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      spreadRadius: 0.1,
                      offset: Offset(4, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _icon[index],
                    SizedBox(height: 8),
                    Text(
                      _itemName[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}