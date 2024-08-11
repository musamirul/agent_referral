import 'package:agent_referral/admin/views/screens/feedback_tap_screen/feedback_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminFeedbackScreen extends StatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  State<AdminFeedbackScreen> createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _feedbackStream = FirebaseFirestore.instance.collection('feedback').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _feedbackStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(child: Text('Feedback', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
            ),
            backgroundColor: Colors.orange.shade400,
          ),
          body: snapshot.data!.docs.length == 0 ? Center(child: Text('No feedback'),):ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final feedbackData = snapshot.data!.docs[index];
              return InkWell(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return FeedbackDetailScreen(
                        feedbackId: '',);
                    },
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade200,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              spreadRadius: 0.1,
                              offset: Offset(4, 5),
                              blurStyle: BlurStyle.normal)
                        ]),
                    child: ListTile(
                        title: Text(feedbackData['title']),
                        subtitle: Text(feedbackData['feedback']),
                        hoverColor: Colors.blue,
                        focusColor: Colors.blue,
                        trailing: Icon(
                          Icons.feedback_rounded,
                        )
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}