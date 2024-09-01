import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalReferWidget extends StatelessWidget {
  const TotalReferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Future<int> getTotalCompleted() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where("status", isEqualTo: "Completed").where('agentId',isEqualTo: _auth.currentUser!.uid).get();
      return querySnapshot.docs.length;
    }

    Future<int> getTotalNew() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where('status', whereIn: ['Pending', 'Approved']).where('agentId',isEqualTo: _auth.currentUser!.uid).get();
      return querySnapshot.docs.length;
    }

    Future<int> getTotalReject() async{
      QuerySnapshot querySnapshot = await _firestore.collection('referral').where('status',isEqualTo: 'Reject').where('agentId',isEqualTo: _auth.currentUser!.uid).get();
      return querySnapshot.docs.length;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('YOURS REFERRALS INFO    >', style: GoogleFonts.lato(fontSize: 13,fontWeight: FontWeight.w900,letterSpacing: 0, color: Colors.black87),),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 30
                    ),
                    child: Icon(
                      Icons.file_open,
                      size: 50,
                      color: Colors.orange.shade400,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'NEW REQUEST',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          FutureBuilder<int>(
                            future: getTotalNew(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return Text(
                                snapshot.data.toString(),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 30
                    ),
                    child: Icon(
                      Icons.file_open,
                      size: 50,
                      color: Colors.orange.shade400,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'REJECTED REQUEST',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          FutureBuilder<int>(
                            future: getTotalReject(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return Text(
                                snapshot.data.toString(),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 30
                    ),
                    child: Icon(
                      Icons.file_copy_rounded,
                      size: 50,
                      color: Colors.orange.shade400,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'APPROVED REQUEST',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                          FutureBuilder<int>(
                            future: getTotalCompleted(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return Text(
                                snapshot.data.toString(),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
