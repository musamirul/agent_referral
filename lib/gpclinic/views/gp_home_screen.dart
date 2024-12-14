import 'package:agent_referral/agent/views/screens/about_screen.dart';
import 'package:agent_referral/agent/views/widgets/header_welcome_widget.dart';
import 'package:agent_referral/gpclinic/views/account_screen.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GpHomeScreen extends StatelessWidget {
  const GpHomeScreen({super.key});

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
        String gpName = snapshot.data!['fullName'] ?? 'No agent name';
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
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
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        } catch (e) {
                          print('Error signing out: $e');
                        }
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.lock_open,
                          color: Colors.white,
                        ),
                        Text(
                          'LOGOUT',
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                )
              ],
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/header.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.7),
                                Colors.orange.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: HeaderWelcomeWidget(),
                    ),
                  )
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
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.amber.shade500),
                      currentAccountPicture: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.orange.shade300,
                        backgroundImage: NetworkImage(snapshot.data!['image']),
                      ),
                      accountName: Text(
                        gpName,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      accountEmail: Text(
                        _auth.currentUser!.email.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (
                              context) => AboutScreen(),));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                          ),
                          title: Text('About'),
                        ),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
