import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PatientDetail extends StatefulWidget {
  const PatientDetail({super.key, required this.referralId});

  final String referralId;

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  CollectionReference patient =
      FirebaseFirestore.instance.collection('referralDID');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  String staffAttendName = "";
  String clinicName = "";

  Future<Map<String, dynamic>> fetchData() async {
    try {
      DocumentSnapshot patientSnapshot =
          await patient.doc(widget.referralId).get();
      Map<String, dynamic> data =
          patientSnapshot.data() as Map<String, dynamic>;

      DocumentSnapshot staffAttendSnapshot =
          await user.doc(data['staffAttending']).get();
      if (staffAttendSnapshot.exists) {
        staffAttendName =
            (staffAttendSnapshot.data() as Map<String, dynamic>)['fullName'];
      }

      DocumentSnapshot clinicSnapshot = await user.doc(data['clinicId']).get();
      if (clinicSnapshot.exists) {
        clinicName =
            (clinicSnapshot.data() as Map<String, dynamic>)['fullName'];
      }

      return data;
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/header.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.blue.withOpacity(0.7),
                              Colors.orange.withOpacity(0.6),
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                    ),
                    Center(
                      child: Padding(padding: EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          
                        ],
                      ),),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
