import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackDetailScreen extends StatefulWidget {
  FeedbackDetailScreen({super.key,required this.feedbackId});
  final String feedbackId;

  @override
  State<FeedbackDetailScreen> createState() => _FeedbackDetailScreenState();
}

class _FeedbackDetailScreenState extends State<FeedbackDetailScreen> {
  CollectionReference feedback = FirebaseFirestore.instance.collection('feedback');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: feedback.doc(widget.feedbackId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange.shade400,centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text('Feedback Detail', style: GoogleFonts.roboto(letterSpacing: 0.9,fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Feedback',style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(width: double.infinity,decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(10),child: Center(child: Text(data['feedback'].toString()))),
                      SizedBox(height: 20,),
                      Text('From',style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(width: double.infinity,decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(10),child: Center(child: Text(data['agentEmail'].toString()))),
                      SizedBox(height: 20,),
                      Text('Title',style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(width: double.infinity,decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(10),child: Center(child: Text(data['title'].toString()))),
                      SizedBox(height: 20,),
                      Text('Description',style: TextStyle(fontSize: 17, letterSpacing: 1, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(width: double.infinity,decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),padding: EdgeInsets.all(10),child: Center(child: Text(data['description'].toString()))),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
