import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({super.key});

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('referral').where("agentId",isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Completed").snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final referralData = snapshot.data!.docs[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return PatientDetail(referralId: referralData['referralId']);
                    },)
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(referralData['patientName'] + " ("+referralData['patientIc']+") "),
                    subtitle: Text(referralData['patientPhone']),
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
