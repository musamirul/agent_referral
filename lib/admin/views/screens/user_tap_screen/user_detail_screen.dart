import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference users = FirebaseFirestore.instance.collection('users');


    Future<String?> getMembershipNo() async {
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('membership')
            .where("agentId", isEqualTo: userId)
            .get();

        // Check if the query returns any documents
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first['membershipNo'] as String;
        } else {
          // Return null if no documents match
          return null;
        }
      } catch (e) {
        // Log and return null in case of error
        print("Error fetching membership number: $e");
        return null;
      }
    }

    //Combined Futruee
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userId).get(),
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
          final userType = data['userType'];


          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: InkWell(
                      onTap: () async {
                        await _auth.signOut();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.lock_open,
                            color: Colors.white,
                          ),
                          Text('LOGOUT',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
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
                        padding: const EdgeInsets.only(top: 10),
                        // Adjust as needed
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.orange.shade300,
                                backgroundImage: NetworkImage(data['image']),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Text(
                                data['fullName'],
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Text(
                                data['email'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: userType=='Agent'?Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withOpacity(1),
                                  Colors.orange.withOpacity(0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 20.0, right: 8.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'CARDHOLDER NAME',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            data['fullName']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'COMPANY',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            data['insuranceOption'],
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Card(
                                          shadowColor: Colors.deepOrange,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text(
                                                'KPJ Klang Specialist Hospital'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'MEMBERSHIP NO',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                          FutureBuilder<String?>(
                                            future: getMembershipNo(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                // Show a loading indicator while waiting for the Future
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                // Display an error message if something goes wrong
                                                return Text(
                                                  'Error',
                                                  style: TextStyle(color: Colors.red),
                                                );
                                              } else if (snapshot.hasData && snapshot.data != null) {
                                                // Display the fetched membership number (now as a string)
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: GoogleFonts.lato(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14),
                                                );
                                              } else {
                                                // Handle the case where no data is found
                                                return Card(
                                                    color: Colors.orange.shade900,
                                                    child: Padding(
                                                    padding: const EdgeInsets.only(top: 3.0,bottom: 3,left: 8,right: 8),
                                              child: Text('Add',style: TextStyle(color: Colors.white),),
                                              ));
                                              }
                                            },
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile Details',
                                style: GoogleFonts.lato(
                                    color: Colors.orange.shade900),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('NRIC No',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade800)),
                              Text(data['icNumber'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 13, fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Registered Email',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade800)),
                              Text(data['email'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 13, fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Contact No',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade800)),
                              Text(data['phoneNumber'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('User Type',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade800)),
                              Text(data['userType'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 13, fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Status',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade800)),

                              //if agent is active
                              data['approved']
                                  ? Card(
                                color: Colors.green.shade700,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3.0,bottom: 3,left: 8,right: 8),
                                  child: Text('Active',style: TextStyle(color: Colors.white),),
                                ),
                              )
                                  : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Pending'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
              ):userType=='Consultant'?Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('User Type : ',style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['userType']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ):Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('User Type : ',style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['userType']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
