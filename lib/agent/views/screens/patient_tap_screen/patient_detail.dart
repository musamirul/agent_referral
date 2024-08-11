import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PatientDetail extends StatefulWidget {
  const PatientDetail({super.key, required this.referralId});

  final String referralId;

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference patient = FirebaseFirestore.instance.collection('referral');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  String doctorName = "";  // Initialize the doctorName variable
  bool isLoadingDoctorName = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: patient.doc(widget.referralId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text("Something went wrong")),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(title: Text('Not Found')),
            body: Center(child: Text("Document does not exist")),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          List<String> urls = List<String>.from(data['fileUrlList']);
          if (data['status'] == "Approved" && doctorName.isEmpty) {
            user.doc(data['doctorAttending']).get().then((value) {
              if (value.exists && value.data() != null) {
                setState(() {
                  // Cast value.data() to Map<String, dynamic>
                  var dataMap = value.data() as Map<String, dynamic>;
                  doctorName = dataMap['fullName'];
                  isLoadingDoctorName = false;
                });
              }
            }).catchError((error) {
              print("Failed to retrieve doctor data: $error");
              isLoadingDoctorName = false;
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    'Patient Detail',
                    style: GoogleFonts.roboto(
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w900,
                      color: Colors.brown.shade900,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.orange.shade400,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (data['status'] == "Approved")
                    isLoadingDoctorName
                        ? CircularProgressIndicator()  // Show loading indicator
                        : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.orange),child: Text("Waiting for "+ doctorName +" to verify patient",style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),  // Show doctor name when loaded
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            spreadRadius: 0.1,
                            offset: Offset(4, 5),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GradientIcon(
                            icon: Icons.person,
                            gradient: LinearGradient(
                              colors: [Colors.orange, Colors.yellow],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            size: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                            child: Text(
                              data['patientName'].toString().toUpperCase(),
                              style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                            child: Text(
                              data['patientIc'],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _buildPatientInfoSection(data),
                  Divider(thickness: 2, color: Colors.grey.shade200),
                  _buildInsuranceInfoSection(data),
                  Divider(thickness: 2, color: Colors.grey.shade200),
                  _buildReferralReasonSection(data),
                  Divider(thickness: 2, color: Colors.grey.shade200),
                  _buildDocumentDownloadSection(urls, context),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text('Patient Detail')),
        );
      },
    );
  }

  Widget _buildPatientInfoSection(Map<String, dynamic> data) {
    return Column(
      children: [
        Container(
          child: Text(
            'Patient & Family Information',
            style: GoogleFonts.roboto(
              letterSpacing: 0.9,
              fontWeight: FontWeight.w900,
              color: Colors.brown.shade500,
              fontSize: 15,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.flag),
          title: Text(data['patientNationality']),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
        ListTile(
          leading: Icon(Icons.safety_divider),
          title: Text(data['patientGender']),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(data['patientAddress']),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
        ListTile(
          leading: Icon(Icons.face),
          title: Text('${data['patientAge']} Years Old'),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
      ],
    );
  }

  Widget _buildInsuranceInfoSection(Map<String, dynamic> data) {
    return Column(
      children: [
        Text(
          'Insurance Information',
          style: GoogleFonts.roboto(
            letterSpacing: 0.9,
            fontWeight: FontWeight.w900,
            color: Colors.brown.shade500,
            fontSize: 15,
          ),
        ),
        if (data['patientPayment'] == "NO")
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text(data['patientIns']),
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
        if (data['patientPayment'] == "NO")
          ListTile(
            leading: Icon(Icons.shield),
            title: Text(data['patientInsNumber']),
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
        if (data['patientPayment'] == "NO")
          ListTile(
            leading: Icon(Icons.policy),
            title: Text(data['patientPolicyPeriod']),
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
        if (data['patientPayment'] == "YES")
          Text('Self Payment Patient'),
      ],
    );
  }

  Widget _buildReferralReasonSection(Map<String, dynamic> data) {
    return Container(
      child: Column(
        children: [
          Text(
            'Referral Information',
            style: GoogleFonts.roboto(
              letterSpacing: 0.9,
              fontWeight: FontWeight.w900,
              color: Colors.brown.shade500,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date Accident / Injury: ' +
                  data['patientDateAccident'] +
                  ' ' +
                  data['patientTimeAccident'],
            ),
          ),
          if (data['patientComplaints'] != null)
            Text('Complaints/History : ' + data['patientComplaints']),
          if (data['reasonReferral'] != null)
            Text('Reason For Referral : ' + data['reasonReferral']),
          if (data['requestSpeciality'] != null)
            Text('Request for Specialist : ' + data['requestSpeciality']),
          if (data['requestTreatment'] != null)
            Text('Request for Treatment : ' + data['requestTreatment']),
          if (data['transportation'] != null)
            Text('Transportation : ' + data['transportation']),
          if (data['patientBed'] != null)
            Text('Request Bed : ' + data['patientBed']),
        ],
      ),
    );
  }

  Widget _buildDocumentDownloadSection(List<String> urls, BuildContext context) {
    return Column(
      children: [
        Text(
          'Patient Document',
          style: GoogleFonts.roboto(
            letterSpacing: 0.9,
            fontWeight: FontWeight.w900,
            color: Colors.brown.shade500,
            fontSize: 15,
          ),
        ),
        ElevatedButton(
          onPressed: () => downloadAllFiles(urls, context),
          child: Text('Download All Documents'),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: urls.length,
          itemBuilder: (context, index) {
            String url = urls[index];
            String fileName = url.split('/').last.split('?').first; // Handling file name from URL
            return ListTile(
              title: Text(fileName, maxLines: 2),
              trailing: IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  downloadFile(url, fileName, context);
                  print(url);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> downloadFile(String url, String fileName, BuildContext context) async {
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = await getExternalStorageDirectory();
        final filePath = '${directory!.path}/$fileName';
        final file = File(filePath);

        if (await file.exists()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$fileName already exists, skipping download.')),
          );
          return;
        }

        final ref = FirebaseStorage.instance.refFromURL(url);
        await ref.writeToFile(file);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloaded $fileName')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission denied')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file: $e')),
      );
    }
  }

  Future<void> downloadAllFiles(List<String> urls, BuildContext context) async {
    for (String url in urls) {
      String fileName = url.split('/').last.split('?').first; // Handling file name from URL
      await downloadFile(url, fileName, context);
      print(fileName);
    }
  }
}