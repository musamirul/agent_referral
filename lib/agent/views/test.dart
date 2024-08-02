// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Test extends StatelessWidget {
//   Test({super.key});
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void retrieveOnce(){
//     _firestore.collection('referral').get().then((value) {
//       value.docs.forEach((element) {
//         print(element.data());
//       },);
//     },);
//   }
//
//   void retrieveDoc(){
//     _auth.currentUser!.uid;
//     _firestore.collection('referral').where("agentId", isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Pending").get().then((value) {
//       value.docs.forEach((element) {
//         print(element.id);
//         print(element.data());
//       });
//     },);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: ElevatedButton(child: Text('Execute Command'),onPressed: () {
//         retrieveDoc();
//       },)),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? feedback;
  String? title;
  String? description;
  TextEditingController feedbackTitle = TextEditingController();
  TextEditingController feedbackDescription = TextEditingController();

  List<String> _feedbackOption = [
    'Concern',
    'Suggestion',
    'Improvement',
    'Constructive'
  ];

  void saveFeedback() async {
    if (_formKey.currentState!.validate()) {
      final referralId = Uuid().v4();
      await _firestore.collection('feedback').doc(referralId).set({
        'agentId': _auth.currentUser!.uid,
        'feedback': feedback,
        'title': feedbackTitle.text,
        'description': feedbackDescription.text,
      }).whenComplete(() {
        feedbackTitle.clear();
        feedbackDescription.clear();
      });

      // Send email after saving feedback
      sendEmail(referralId);
    }
  }

  void sendEmail(String referralId) async {
    String username = 'your-email@example.com';  // Your email address
    String password = 'your-email-password';    // Your email password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Your Name')
      ..recipients.add('recipient@example.com')  // Recipient email
      ..subject = 'New Feedback Submitted: $referralId'
      ..text = 'Feedback Type: $feedback\n'
          'Title: ${feedbackTitle.text}\n'
          'Description: ${feedbackDescription.text}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  hint: Text('Select Feedback'),
                  items: _feedbackOption.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    feedback = value as String?;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: feedbackTitle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Feedback Title';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(label: Text('Feedback Title')),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: feedbackDescription,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter description';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 8,
                  maxLength: 800,
                  decoration: InputDecoration(
                      label: Text('Description'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    saveFeedback();
                  },
                  child: Text('Save Feedback'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
