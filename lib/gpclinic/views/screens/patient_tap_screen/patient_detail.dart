import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Patient Detail')),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text("Something went wrong")),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text('Not Found')),
            body: Center(child: Text("Document does not exist")),
          );
        }

        Map<String, dynamic> data = snapshot.data!;
        
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
                      child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 10,
                              ),
                              child: Text(data['patientName'], style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.w900),),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(data['patientIdentity'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildPatientInfoSection(data),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientInfoSection(Map<String,dynamic> data){
    Timestamp? firebaseTimestamp = data['dateCreated'] as Timestamp?;
    DateTime? dateTime = firebaseTimestamp?.toDate();
    String formattedDate = DateFormat("MMMM d, y 'at' hh:mm:ss a")
        .format(dateTime!.toUtc());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Patient Details',
                  style: GoogleFonts.lato(
                      color: Colors.orange.shade900),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Name',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientName'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Identity Number',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientIdentity'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Gender',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientGender'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Nationality',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientNationality'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Contact Number',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientPhone'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Home Address',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['patientAddress'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              Center(
                child: Text(
                  'Patient Diagnostic Detail',
                  style: GoogleFonts.lato(
                      color: Colors.orange.shade900),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Diagnostic Imaging Option',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['didOption'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Remarks',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(data['remarks'],
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('Date Created',
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade800)),
              Text(formattedDate,
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.bold)),

            ],
          ),
        ),
      ],
    );
  }
}
