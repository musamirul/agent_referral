import 'package:agent_referral/agent/views/screens/about_screen.dart';
import 'package:agent_referral/agent/views/screens/account_screen.dart';
import 'package:agent_referral/agent/views/widgets/banner_widget.dart';
import 'package:agent_referral/agent/views/widgets/facility_widget.dart';
import 'package:agent_referral/agent/views/widgets/header_welcome_widget.dart';
import 'package:agent_referral/agent/views/widgets/total_refer_widget.dart';
import 'package:agent_referral/agent/views/widgets/welcome_text.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data available');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('done');
        }
        // Extract the agentNumber from the document
        String agentNumber = snapshot.data!['agentNumber'] ?? 'No agent number';
        String agentName = snapshot.data!['fullName'] ?? 'No agent name';

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
                      child: HeaderWelcomeWidget(),
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
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade500,
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.orange.shade300,
                        backgroundImage: NetworkImage(snapshot.data!['image']),
                      ),
                      accountName: Text(agentName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,fontSize: 20)),
                      accountEmail: Text(_auth.currentUser!.email.toString(),
                          style: TextStyle(color: Colors.black)),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 25),
                    //   child: ListTile(
                    //       leading: Icon(
                    //         Icons.home,
                    //       ),
                    //       title: Text(
                    //         'Home',
                    //       )),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutScreen(),));
                        },
                        child: ListTile(
                            leading: Icon(
                              Icons.info,
                            ),
                            title: Text('About')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AccountScreen()));
                        },
                        child: ListTile(
                            leading: Icon(
                              Icons.settings,
                            ),
                            title: Text('Profile')),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                    ),
                    title: Text('Logout'),
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/building.png',
                  // Make sure to add the image in the assets folder and specify it in pubspec.yaml
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      BannerWidget(),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 30.0),
                      //   child: WelcomeText(),
                      // ),
                      SizedBox(height: 10,),
                      FacilityWidget(),
                      SizedBox(height: 10,),
                      TotalReferWidget(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
