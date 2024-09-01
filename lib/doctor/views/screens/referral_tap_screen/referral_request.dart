import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReferralRequestScreen extends StatefulWidget {
  const ReferralRequestScreen({super.key});

  @override
  State<ReferralRequestScreen> createState() => _ReferralRequestScreenState();
}

class _ReferralRequestScreenState extends State<ReferralRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('referral')
        .where("doctorAttending", isEqualTo: "empty")
        .where("status", isEqualTo: "Pending")
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

        return snapshot.data!.docs.length == 0
            ? Center(
                child: Text('No pending referral requested'),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final referralData = snapshot.data!.docs[index];
                  final referralId = referralData['referralId'];

                  return Dismissible(
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirm"),
                            content: Text(
                                "Are you sure you wish to delete this referral"),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () async {
                                bool confirm = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirm Referral'),
                                      content: Text(
                                          'Are you sure you want to claim this referral'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Cancel")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text("Claim"))
                                      ],
                                    );
                                  },
                                );
                                if (confirm) {
                                  _firestore
                                      .collection('referral')
                                      .doc(referralData['referralId'])
                                      .update({
                                    'doctorAttending': _auth.currentUser!.uid,
                                    'status': 'Approved'
                                  });

                                  _firestore.collection('mail').doc(referralId).set({
                                    'to': 'itservices@kpjklang.com',
                                    'from': _auth.currentUser!.email,
                                    'message': {
                                      'subject': 'Referral :' + referralData['patientName']+', Approved by :'+_auth.currentUser!.email.toString(),
                                      'text': _auth.currentUser!.email! + '\n\n' +
                                          'status: Approved',
                                      'html': '''
                                          <div style="font-family: Arial, sans-serif; color: #333;">
                                            <p><strong>From:</strong> ${_auth.currentUser!.email}</p>
                                            <p><strong>Patient Name:</strong> ${referralData['patientName']}</p>
                                            <p><strong>Patient IC:</strong> ${referralData['patientIc']}</p>
                                            <p><strong>Nationality:</strong> ${referralData['patientNationality']}</p>
                                            <p><strong>Description:</strong></p>
                                            <p style="padding: 10px; background-color: #f9f9f9; border-radius: 5px;">
                                              ${referralData['patientPhone']?.replaceAll('\n', '<br/>')}<br/>
                                              ${referralData['patientAddress']?.replaceAll('\n', '<br/>')}<br/>
                                              ${referralData['patientComplaints']?.replaceAll('\n', '<br/>')}<br/>
                                              ${referralData['reasonReferral']?.replaceAll('\n', '<br/>')}<br/>
                                            </p>
                                            <p>
                                              Please check your app to complete the referral.
                                            </p>
                                          </div>
                                        ''',
                                    }
                                  });

                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Get',
                                style: TextStyle(color: Colors.white),
                              ),
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
