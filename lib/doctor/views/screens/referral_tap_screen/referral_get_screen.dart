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
            final referralId = referralData['referralId'];

            return Dismissible(
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirm"),
                      content:
                      Text("Are you sure you wish to reject this referral"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Reject")),
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
                color: Colors.orange,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100),
                        onPressed: () {}, icon: Icon(Icons.cancel, size: 40, color: Colors.red), label: Text('Reject Referral',)
                    )
                  ],
                ),
              ),
              key: ValueKey<int>(index),
              onDismissed: (direction) {
                setState(() {
                  _firestore
                      .collection('referral')
                      .doc(referralData['referralId'])
                      .update(
                      {
                        'status' :'Reject',
                      }
                  );

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
                        onPressed: () async{
                          bool confirm = await showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Referral'),
                              content: Text('Are you sure you want to Confirm this referral?'),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop(false);
                                }, child: Text('Cancel'),),
                                ElevatedButton(onPressed: () {
                                  Navigator.of(context).pop(true);
                                }, child: Text('Completed')),
                              ],
                            );
                          },);
                          if(confirm){
                            _firestore.collection('referral').doc(referralData['referralId']).update({'status':'Completed'});
                            _firestore.collection('mail').doc(referralId).set({
                              'to': referralData['agentEmail'],
                              'from': _auth.currentUser!.email,
                              'message': {
                                'subject': 'Referral :' + referralData['patientName']+', Completed by :'+_auth.currentUser!.email.toString(),
                                'text': _auth.currentUser!.email! + '\n\n' +
                                    'status: Completed',
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
