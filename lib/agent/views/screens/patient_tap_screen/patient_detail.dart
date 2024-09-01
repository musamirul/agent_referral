import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:open_file/open_file.dart';
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
  CollectionReference patient =
      FirebaseFirestore.instance.collection('referral');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  String doctorName = "";
  String agentName = "";
  bool isLoadingDoctorName = true;

  Future<Map<String, dynamic>> fetchData() async {
    try {
      DocumentSnapshot patientSnapshot =
          await patient.doc(widget.referralId).get();
      Map<String, dynamic> data =
          patientSnapshot.data() as Map<String, dynamic>;

      DocumentSnapshot doctorSnapshot =
          await user.doc(data['doctorAttending']).get();
      if (doctorSnapshot.exists) {
        doctorName =
            (doctorSnapshot.data() as Map<String, dynamic>)['fullName'];
      }

      DocumentSnapshot agentSnapshot = await user.doc(data['agentId']).get();
      if (agentSnapshot.exists) {
        agentName = (agentSnapshot.data() as Map<String, dynamic>)['fullName'];
      }

      return data;
    } catch (e) {
      print("Error fetching data: $e");
      throw e; // Re-throw the error to handle it in FutureBuilder
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
        List<String> urls = data['fileUrlList'] != null
            ? List<String>.from(data['fileUrlList'])
            : [];

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              // Make the AppBar background transparent
              elevation: 0,
              // Remove shadow
              flexibleSpace: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/header.jpg',
                      // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay (optional)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.7),
                            Colors.orange.withOpacity(0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  // Centered title
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      // Adjust as needed
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 10),
                            child: Text(
                              data['patientName'].toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              data['patientIc'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (data['status'] == "Approved")
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orange),
                                child: Text(
                                  "Waiting for $doctorName to verify patient",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          if (data['status'] == "Pending")
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orange),
                                child: Text(
                                  "Waiting for doctor to add to their records.",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          // if (data['status'] == "Approved")
                          //   isLoadingDoctorName
                          //       ? CircularProgressIndicator()
                          //       : Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.orange),child: Text("Waiting for "+ doctorName +" to verify patient",style: TextStyle(fontWeight: FontWeight.bold),)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // if (data['status'] == "Approved")
                //   isLoadingDoctorName
                //       ? CircularProgressIndicator()
                //       : Padding(
                //     padding: const EdgeInsets.only(top: 10),
                //     child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.orange),child: Text("Waiting for "+ doctorName +" to verify patient",style: TextStyle(fontWeight: FontWeight.bold),)),
                //   ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 10,
                //           spreadRadius: 0.1,
                //           offset: Offset(4, 5),
                //           blurStyle: BlurStyle.normal,
                //         ),
                //       ],
                //     ),
                //     child: Column(
                //       children: [
                //         GradientIcon(
                //           icon: Icons.person,
                //           gradient: LinearGradient(
                //             colors: [Colors.orange, Colors.yellow],
                //             begin: Alignment.topLeft,
                //             end: Alignment.bottomRight,
                //           ),
                //           size: 50,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                //           child: Text(
                //             data['patientName'].toString().toUpperCase(),
                //             style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                //           child: Text(
                //             data['patientIc'],
                //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                data['doctorAttending'] != "empty"
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Assign Doctor : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(doctorName),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Assign Agent : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(agentName),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Assign Doctor : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text('Not Assigned Yet!'),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Assign Agent : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(agentName),
                                ],
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
                data['fileUrlList'] != null
                    ? _buildDocumentDownloadSection(urls, context)
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Text(
                          'No Document Attached',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientInfoSection(Map<String, dynamic> data) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            'PATIENT & FAMILY INFORMATION',
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
          'INSURANCE INFORMATION',
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
        if (data['patientPayment'] == "YES") Text('Self Payment Patient'),
      ],
    );
  }

  Widget _buildReferralReasonSection(Map<String, dynamic> data) {
    return Container(
      child: Column(
        children: [
          Text(
            'REFERRAL INFORMATION',
            style: GoogleFonts.roboto(
              letterSpacing: 0.9,
              fontWeight: FontWeight.w900,
              color: Colors.brown.shade500,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Date Accident / Injury : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['patientDateAccident'] +
                            ' ' +
                            data['patientTimeAccident'],
                      ),
                    ],
                  ),
                ),
                if (data['patientComplaints'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Complaints/History : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['patientComplaints']),
                      ],
                    ),
                  ),
                if (data['reasonReferral'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Reason For Referral : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['reasonReferral']),
                      ],
                    ),
                  ),
                if (data['requestSpeciality'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Request for Specialist : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['requestSpeciality']),
                      ],
                    ),
                  ),
                if (data['requestTreatment'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Request for Treatment : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['requestTreatment']),
                      ],
                    ),
                  ),
                if (data['transportation'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Transportation : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['transportation']),
                      ],
                    ),
                  ),
                if (data['patientBed'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'Request Bed : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['patientBed']),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentDownloadSection(
      List<String> urls, BuildContext context) {
    return Column(
      children: [
        Text(
          'PATIENT DOCUMENT',
          style: GoogleFonts.roboto(
            letterSpacing: 0.9,
            fontWeight: FontWeight.w900,
            color: Colors.brown.shade500,
            fontSize: 15,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => downloadAllFiles(urls, context),
          icon: Icon(Icons.save),
          label: Text('Download All Documents'),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: urls.length,
            itemBuilder: (context, index) {
              String url = urls[index];
              String fileName = url
                  .split('/')
                  .last
                  .split('?')
                  .first; // Handling file name from URL
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () async {
                        // Call your method to open the file. This could be using a PDF viewer, image viewer, or a web view.
                        await openFileFromUrl(url, fileName);
                      },
                      child: Text(
                        fileName,
                        style: TextStyle(
                          color: Colors.blue,
                          // Makes the text look like a clickable link
                          decoration:
                              TextDecoration.underline, // Underlines the text
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.save_alt),
                      onPressed: () {
                        downloadFile(url, fileName, context);
                        print(url);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> openFileFromUrl(String url, String fileName) async {
    try {
      // Get the directory to save the file
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');

      // Download the file
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);

      // Open the file
      await openFile(file.path);
    } catch (e) {
      print("Error downloading or opening file: $e");
    }
  }

  Future<void> openFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Failed to open file: ${result.message}");
      }
    } catch (e) {
      print("Error opening file: $e");
    }
  }

  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<void> downloadFile(
      String url, String fileName, BuildContext context) async {
    if (await requestStoragePermission()) {
      try {
        final externalDir = await getExternalStorageDirectories(
            type: StorageDirectory.downloads);

        if (externalDir != null && externalDir.isNotEmpty) {
          String savePath = externalDir.first.path;

          await FlutterDownloader.enqueue(
            url: url,
            savedDir: savePath,
            fileName: fileName,
            // Explicitly set the file name
            showNotification: true,
            openFileFromNotification: true,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $fileName to $savePath')),
          );
        } else {
          throw Exception('Unable to access the Downloads directory.');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download file: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Storage permission is required to download files')),
      );
    }
  }

  Future<void> downloadAllFiles(List<String> urls, BuildContext context) async {
    for (String url in urls) {
      String fileName =
          url.split('/').last.split('?').first; // Handling file name from URL
      await downloadFile(url, fileName, context);
      print(fileName);
    }
  }
}
