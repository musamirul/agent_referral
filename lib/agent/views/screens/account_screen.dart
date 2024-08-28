import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_auth.currentUser!.uid).get(),
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
                          Icon(Icons.lock_open,color: Colors.white,),
                          Text('LOGOUT',style: GoogleFonts.lato(color: Colors.white,fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.transparent, // Make the AppBar background transparent
                elevation: 0, // Remove shadow
                flexibleSpace: Stack(
                  children: [
                    // Background image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/header.jpg', // Replace with your image path
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
                        padding: const EdgeInsets.only(top: 20), // Adjust as needed
                        child:Column(
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.orange.shade300,
                                backgroundImage: NetworkImage(data['image']),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(data['fullName'], style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text('Agent Number : ' +data['agentNumber'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(thickness: 0.7,color: Colors.grey,),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(data['email']),
                  ),ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(data['phoneNumber']),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text(data['icNumber']),
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text(data['insuranceOption']),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(data['userType']),
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
