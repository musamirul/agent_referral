import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DiagnosticReferralController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createDiagnostic(
      String name,
      String identity,
      String phone,
      String nationality,
      //String foreignNationality,
      String address,
      String gender,
      String didOption,
      String remarks,
      String referralId
      )async{
    String res = 'some error occurred';
    await _firestore.collection('referralDID').doc(referralId).set({
      'clinicId' : _auth.currentUser?.uid,
      'status' : 'Pending',
      'patientName' : name,
      'patientIdentity' : identity,
      'patientPhone' : phone,
      'patientNationality' : nationality,
      //'foreignNationality' : foreignNationality,
      'patientAddress' : address,
      'patientGender' : gender,
      'didOption' : didOption,
      'remarks' : remarks,
      'dateCreated' : DateTime.now(),
      'staffAttending' : 'empty',
      'referralId' : referralId,
    });
    return res;

  }
}