import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientRegisteredListScreen extends StatefulWidget {
  PatientRegisteredListScreen({super.key});

  @override
  State<PatientRegisteredListScreen> createState() => _PatientRegisteredListScreenState();
}

class _PatientRegisteredListScreenState extends State<PatientRegisteredListScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('referral').where("agentId",isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Pending").snapshots();
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
            return Dismissible(
              confirmDismiss: (direction) async{
                return await showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Confirm"),
                    content: Text("Are you sure you wish to delete this referral"),
                    actions: [
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).pop(true);
                      }, child: Text("Delete")),
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).pop(false);
                      }, child: Text("Cancel"))
                    ],
                  );
                },);
              },
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(Icons.delete,size: 40,color: Colors.white),
              ),
              key: ValueKey<int>(index),
              onDismissed: (direction) {
                setState(() {
                  _firestore.collection('referral').doc(referralData['referralId']).delete();
                });
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PatientDetail(referralId: referralData['referralId']);
                      },)
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.lightBlueAccent.shade100, borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(referralData['patientName']),
                      subtitle: Text(referralData['patientIc']),
                      hoverColor: Colors.blue,
                      focusColor: Colors.blue,
                      trailing: IconButton(onPressed: () {  }, icon: Icon(Icons.edit),
                      ),
                    ),
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
