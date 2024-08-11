import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReferralGetScreen extends StatefulWidget {
  const ReferralGetScreen({super.key});

  @override
  State<ReferralGetScreen> createState() => _ReferralGetScreenState();
}

class _ReferralGetScreenState extends State<ReferralGetScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('referral')
        .where("doctorAttending", isEqualTo: _auth.currentUser!.uid)
        .where("status", isEqualTo: "Approved")
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return snapshot.data!.docs.length == 0 ? Center(child: Text('No current referral'),):ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final referralData = snapshot.data!.docs[index];
            return Dismissible(
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirm"),
                      content:
                      Text("Are you sure you wish to delete this referral"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Delete")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  },
                );
              },
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(Icons.delete, size: 40, color: Colors.white),
              ),
              key: ValueKey<int>(index),
              onDismissed: (direction) {
                setState(() {
                  _firestore
                      .collection('referral')
                      .doc(referralData['referralId'])
                      .delete();
                });
              },
              child: InkWell(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return PatientDetail(
                          referralId: referralData['referralId']);
                    },
                  ));
                },
                child: Padding(
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
                      trailing: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,),
                        onPressed: () {
                          _firestore.collection('referral').doc(referralData['referralId']).update({'status':'Completed'});
                        },
                        icon: Icon(Icons.send,color: Colors.white,), label: Text('Completed',style: TextStyle(color: Colors.white),),
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
