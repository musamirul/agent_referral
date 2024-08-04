import 'package:agent_referral/admin/admin_main_screen.dart';
import 'package:agent_referral/agent/models/agent_user_models.dart';
import 'package:agent_referral/agent/views/agent_main_screen.dart';
import 'package:agent_referral/agent/views/auth/agent_registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _agentStream =
        FirebaseFirestore.instance.collection('agents');

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _agentStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (!snapshot.data!.exists) {
            return AgentRegistrationScreen();
          }
          if(_auth.currentUser!.uid == 'LNWnCehzNDgouLiw6DcN3TqQwHB3') {
            return AdminMainScreen();
          }
          AgentUserModel agentUserModel = AgentUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (agentUserModel.approved == true) {
            return AgentMainScreen();

          } else
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        agentUserModel.image.toString(),
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      agentUserModel.fullName.toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Your request has been submitted to admin. please wait for admin to verify your account',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
