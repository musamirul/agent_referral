import 'package:agent_referral/admin/admin_main_screen.dart';
import 'package:agent_referral/agent/views/agent_main_screen.dart';
import 'package:agent_referral/doctor/doctor_main_screen.dart';
import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:agent_referral/views/screens/authentication_screens/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userStream = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (userSnapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return LoginScreen();
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: _userStream.doc(_auth.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return RegisterScreen();
              }

              final userData = snapshot.data!;

              if (snapshot.data!['userId'] == 'LNWnCehzNDgouLiw6DcN3TqQwHB3') {
                return AdminMainScreen();
              }

              if (snapshot.data!['userType'] == 'Agent' && snapshot.data!['approved'] == true) {
                return AgentMainScreen();
              }

              if (snapshot.data!['userType'] == 'Consultant' && snapshot.data!['approved'] == true) {
                return DoctorMainScreen();
              }

              return _buildPendingApprovalScreen(userData);
            },
          );
        },
      ),
    );
  }

  Widget _buildPendingApprovalScreen(DocumentSnapshot userData) {
    return Container(
      decoration: BoxDecoration(color: Colors.brown),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/building.png'),fit: BoxFit.cover),
              gradient: RadialGradient(colors: [Colors.white, Colors.white]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(userData['image'].toString()),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(5),
                  //   child: Image.network(
                  //     userData['image'].toString(),
                  //     width: 110,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Text(
                    userData['fullName'].toString().toUpperCase(),
                    style: GoogleFonts.lato(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.brown.shade900,
                    ),
                  ),
                  Text(
                    'Your request has been submitted to admin. Please wait for admin to verify your account.',
                    style: GoogleFonts.lato(fontSize: 15, letterSpacing: 0.5),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}