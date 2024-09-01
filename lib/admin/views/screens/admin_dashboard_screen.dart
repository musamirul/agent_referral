import 'package:agent_referral/admin/views/screens/admin_doctor_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_feedback_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_package_screen.dart';
import 'package:agent_referral/admin/views/screens/agent_registered_screen.dart';
import 'package:agent_referral/admin/views/widgets/total_referral_widget.dart';
import 'package:agent_referral/agent/views/screens/about_screen.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
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
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: InkWell(
                onTap: () async {
                  bool shouldLogout = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout) {
                    try {
                      await _auth.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } catch (e) {
                      print('Error signing out: $e');
                      // Optionally, show an error message to the user
                    }
                  }
                },
                child: Column(
                  children: [
                    Icon(Icons.lock_open, color: Colors.white),
                    Text(
                      'LOGOUT',
                      style: GoogleFonts.lato(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent, // Make the AppBar background transparent
          elevation: 0, // Remove shadow
          flexibleSpace: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/header.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay (optional)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.7),
                        Colors.orange.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Centered title
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5), // Adjust as needed
                  child: Text(
                    'Dashboard',textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: 0.5, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // DrawerHeader(child: Text('Hi Admin')),
                UserAccountsDrawerHeader(decoration: BoxDecoration(color: Colors.orange.shade300),accountName: Text('Hi Admin',style: TextStyle(color: Colors.black),), accountEmail: Text(_auth.currentUser!.email.toString(),style: TextStyle(color: Colors.black),),),
                //Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: ListTile(leading: Icon(Icons.home,),title: Text('Home')),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ));
                    },
                    child: ListTile(
                        leading: Icon(
                          Icons.info,
                        ),
                        title: Text('About')),
                  ),
                ),
                //Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: ListTile(leading: Icon(Icons.settings,),title: Text('Settings')),)
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout,),title: Text('Logout'),onTap: () async{
                await _auth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),)
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('TOTAL REFERRAL REQUEST', style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.brown.shade900),),
            ),
            TotalReferralWidget(),
            // GridView.builder(
            //   shrinkWrap: true,
            //   itemCount: _itemName.length,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 1,
            //     crossAxisSpacing: 8,
            //     mainAxisSpacing: 8,
            //   ),
            //   itemBuilder: (BuildContext context, int index) {
            //     return InkWell(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) {
            //             print("Navigating to AdminDoctorScreen");
            //             return _pages[index];
            //           }),
            //         );
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             gradient: RadialGradient(
            //               colors: [Colors.yellow.shade300, Colors.orange.shade200],
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey,
            //                 blurRadius: 10,
            //                 spreadRadius: 0.1,
            //                 offset: Offset(4, 5),
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               _icon[index],
            //               SizedBox(height: 8),
            //               Text(
            //                 _itemName[index],
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                   letterSpacing: 2,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}