import 'package:agent_referral/agent/views/screens/about_screen.dart';
import 'package:agent_referral/doctor/views/screens/doctor_account_screen.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<int> getTotalCompleted() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where("status", isEqualTo: "Completed").where('doctorAttending',isEqualTo: _auth.currentUser!.uid).get();
      return querySnapshot.docs.length;
    }

    Future<int> getTotalNew() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where('status',isEqualTo: 'Pending').where('doctorAttending',isEqualTo: 'empty').get();
      return querySnapshot.docs.length;
    }

    Future<int> getTotalReject() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where('status',isEqualTo: 'Reject').where('doctorAttending',isEqualTo: _auth.currentUser!.uid).get();
      return querySnapshot.docs.length;
    }

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
        String doctorName = snapshot.data!['fullName'] ?? 'No agent name';

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
              backgroundColor: Colors.transparent,
              // Make the AppBar background transparent
              elevation: 0,
              // Remove shadow
              flexibleSpace: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/header.jpg',
                      // Replace with your image path
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
                      padding: const EdgeInsets.only(top: 5),
                      // Adjust as needed
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
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade500,
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.orange.shade300,
                        backgroundImage: NetworkImage(snapshot.data!['image']),
                      ),
                      accountName: Text(doctorName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      accountEmail: Text(_auth.currentUser!.email.toString(),
                          style: TextStyle(color: Colors.black)),
                    ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DoctorAccountScreen()));
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 20,
                                      right: 30
                                  ),
                                  child: Icon(
                                    Icons.file_open,
                                    size: 100,
                                    color: Colors.orange.shade400,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'NEW REQUEST',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<int>(
                                          future: getTotalNew(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            }
                                            return Text(
                                              snapshot.data.toString(),
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 20,
                                      right: 30
                                  ),
                                  child: Icon(
                                    Icons.file_open,
                                    size: 100,
                                    color: Colors.orange.shade400,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'REJECTED REQUEST',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<int>(
                                          future: getTotalReject(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            }
                                            return Text(
                                              snapshot.data.toString(),
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 20,
                                      right: 30
                                  ),
                                  child: Icon(
                                    Icons.file_copy_rounded,
                                    size: 100,
                                    color: Colors.orange.shade400,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'APPROVED REQUEST',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<int>(
                                          future: getTotalCompleted(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            }
                                            return Text(
                                              snapshot.data.toString(),
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
