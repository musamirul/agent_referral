import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void retrieveOnce(){
    _firestore.collection('referral').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      },);
    },);
  }

  void retrieveDoc(){
    _auth.currentUser!.uid;
    _firestore.collection('referral').where("agentId", isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Pending").get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
        print(element.data());
      });
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(child: Text('Execute Command'),onPressed: () {
        retrieveDoc();
      },)),
    );
  }
}
