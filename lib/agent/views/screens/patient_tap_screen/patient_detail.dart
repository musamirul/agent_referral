import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientDetail extends StatelessWidget {
  const PatientDetail({super.key, required this.referralId});

  final String referralId;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference patient =
        FirebaseFirestore.instance.collection('referral');
    return FutureBuilder<DocumentSnapshot>(
        future: patient.doc(referralId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Patient Detail',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue,
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      data['patientName'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      data['patientIc'],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 0.7,
                      color: Colors.grey,
                    ),
                  ),
                  Text('Patient & Family Information'),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(data['patientPhone'],style: TextStyle()),
                  ),
                  ListTile(
                    leading: Icon(Icons.flag),
                    title: Text(data['patientNationality']),
                  ),
                  ListTile(
                    leading: Icon(Icons.safety_divider),
                    title: Text(data['patientGender']),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(data['patientAddress']),
                  ),
                  if(data['patientPayment']=="NO")
                    Divider(thickness: 2,color: Colors.grey.shade200,),
                    Text('Insurance Information'),
                    ListTile(
                      leading: Icon(Icons.health_and_safety),
                      title: Text(data['patientIns']),
                    ),
                    ListTile(
                      leading: Icon(Icons.shield),
                      title: Text(data['patientInsNumber']),
                    ),
                    ListTile(
                      leading: Icon(Icons.policy),
                      title: Text(data['patientPolicyPeriod']),
                    ),
                  Divider(thickness: 2,color: Colors.grey.shade200,),
                  Text('Reason For Referral'),
                  Column(
                    children: [
                      Text('Date Accident / Injury : '+data['patientDateAccident']+' '+data['patientTimeAccident'])
                    ],
                  ),
                ],
              ),
            );
          }

          return Text("loading");
        },
    );
  }
}
