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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('referral')
        .where("agentId", isEqualTo: _auth.currentUser!.uid)
        .where('status', whereIn: ['Reject', 'Completed'])
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final referralData = snapshot.data!.docs[index];
            return InkWell(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return PatientDetail(
                        referralId: referralData['referralId']);
                  },
                ));
              },
              child: referralData['status']=='Completed'?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            spreadRadius: 0.1,
                            offset: Offset(4, 5),
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: ListTile(
                      title: Text(referralData['patientName']),
                      subtitle: Text(referralData['patientIc']),
                      hoverColor: Colors.blue,
                      focusColor: Colors.blue,
                      trailing: Icon(Icons.done_all)
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            spreadRadius: 0.1,
                            offset: Offset(4, 5),
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: ListTile(
                      title: Text(referralData['patientName']),
                      subtitle: Text(referralData['patientIc']),
                      hoverColor: Colors.blue,
                      focusColor: Colors.blue,
                      trailing: Icon(Icons.cancel)
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
