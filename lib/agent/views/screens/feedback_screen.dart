// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   FeedbackScreen({super.key});
//
//   @override
//   State<FeedbackScreen> createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   String? feedback;
//   String? title;
//   String? description;
//   TextEditingController feedbackTitle = TextEditingController();
//   TextEditingController feedbackDescription = TextEditingController();
//
//   List<String> _feedbackOption = [
//     'Concern',
//     'Sugestion',
//     'Improvement',
//     'Constructive'
//   ];
//
//   void saveFeedback() async{
//     if(_formKey.currentState!.validate()){
//       final referralId = Uuid().v4();
//       await _firestore.collection('feedback').doc(referralId).set({
//         'agentId':_auth.currentUser!.uid,
//         'feedback':feedback,
//         'title':feedbackTitle.text,
//         'description':feedbackDescription.text,
//       }).whenComplete(() {
//           feedbackTitle.clear();
//           feedbackDescription.clear();
//       },);
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feedback Form'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 DropdownButtonFormField(
//                   hint: Text('Select Feedback'),
//                   items: _feedbackOption.map<DropdownMenuItem<String>>((value) {
//                     return DropdownMenuItem(value: value, child: Text(value));
//                   }).toList(),
//                   onChanged: (value) {
//                     feedback = value;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: feedbackTitle,
//                   validator: (value) {
//                     if(value!.isEmpty){
//                       return 'Enter Feedback Title';
//                     }else{
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(label: Text('Feedback Title')),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: feedbackDescription,
//                   validator: (value) {
//                     if(value!.isEmpty){
//                       return 'Enter description';
//                     }else{
//                       return null;
//                     }
//                   },
//                   maxLines: 8,
//                   maxLength: 800,
//                   decoration: InputDecoration(
//                       label: Text('Description'),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                 ),
//                 SizedBox(height: 30,),
//                 ElevatedButton(
//                     onPressed: () {
//                       saveFeedback();
//                     }, child: Text('Save Feedback')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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
      final feedbackId = Uuid().v4();
      // await _firestore.collection('feedback').doc(feedbackId).set({
      //   'agentId': _auth.currentUser!.uid,
      //   'agentEmail' : _auth.currentUser!.email,
      //   'feedback': feedback,
      //   'title': feedbackTitle.text,
      //   'description': feedbackDescription.text,
      //   'status': 'Pending',
      // }).whenComplete(() {
      //   feedbackTitle.clear();
      //   feedbackDescription.clear();
      //   sendEmail(feedbackId);
      // });

      await _firestore.collection('mail').doc(feedbackId).set({
        'to': 'musamirul.kpj@gmail.com',
        'from': _auth.currentUser!.email,
        'message': {
          'subject': '('+feedback!+') '+feedbackTitle.text,
          'text': _auth.currentUser!.email! + '\n\n' +
                  'Description: ' + feedbackDescription.text,
          'html': '''
                  <div style="font-family: Arial, sans-serif; color: #333;">
                      <p><strong>From:</strong> ${_auth.currentUser!.email!}</p>
                      <p><strong>Feedback Title:</strong> ${feedbackTitle.text}</p>
                      <p><strong>Feedback Type:</strong> ${feedback}</p>
                      <p><strong>Description:</strong></p>
                      <p style="padding: 10px; background-color: #f9f9f9; border-radius: 5px;">
                          ${feedbackDescription.text.replaceAll('\n', '<br>')}
                      </p>
                  </div>
              ''',
        }
      }).whenComplete((){
        feedbackTitle.clear();
        feedbackDescription.clear();
        // sendEmail(feedbackId);
      });
    }
  }

  // void sendEmail(String feedbackId) async {
  //   String username = 'musamirul123@gmail.com'; // Your Gmail address
  //   String password = '';    // Your Gmail App Password
  //
  //   final smtpServer = gmail(username, password);
  //
  //   final message = Message()
  //     ..from = Address(username, 'ameirul')
  //     ..recipients.add('musamirul123@gmail.com')  // Recipient email
  //     ..subject = 'New Feedback Submitted: $feedbackId'
  //     ..text = 'Feedback Type: $feedback\n'
  //         'Title: ${feedbackTitle.text}\n'
  //         'Description: ${feedbackDescription.text}';
  //
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent. \n${e.toString()}');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(child: Text('Feedback Form', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                  hint: Text('Select Feedback'),
                  items: _feedbackOption.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    feedback = value;
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
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.house),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Feedback Title',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
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
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Feedback Description',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton.icon(
                  onPressed: () {
                    saveFeedback();
                  },
                  icon: Icon(Icons.save,color: Colors.white),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, fixedSize: Size(300, 30),),
                  label: Text('Save Feedback', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}