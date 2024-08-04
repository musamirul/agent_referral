// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // class Test extends StatelessWidget {
// //   Test({super.key});
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   void retrieveOnce(){
// //     _firestore.collection('referral').get().then((value) {
// //       value.docs.forEach((element) {
// //         print(element.data());
// //       },);
// //     },);
// //   }
// //
// //   void retrieveDoc(){
// //     _auth.currentUser!.uid;
// //     _firestore.collection('referral').where("agentId", isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Pending").get().then((value) {
// //       value.docs.forEach((element) {
// //         print(element.id);
// //         print(element.data());
// //       });
// //     },);
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(child: ElevatedButton(child: Text('Execute Command'),onPressed: () {
// //         retrieveDoc();
// //       },)),
// //     );
// //   }
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
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
//     'Suggestion',
//     'Improvement',
//     'Constructive'
//   ];
//
//   void saveFeedback() async {
//     if (_formKey.currentState!.validate()) {
//       final referralId = Uuid().v4();
//       await _firestore.collection('feedback').doc(referralId).set({
//         'agentId': _auth.currentUser!.uid,
//         'feedback': feedback,
//         'title': feedbackTitle.text,
//         'description': feedbackDescription.text,
//       }).whenComplete(() {
//         feedbackTitle.clear();
//         feedbackDescription.clear();
//       });
//
//       // Send email after saving feedback
//       sendEmail(referralId);
//     }
//   }
//
//   void sendEmail(String referralId) async {
//     String username = 'musamirul.kpj@gmail.com';  // Your email address
//     String password = 'qwerty30';    // Your email password
//
//     final smtpServer = gmail(username, password);
//
//     final message = Message()
//       ..from = Address(username, 'ameirul')
//       ..recipients.add('musamirul.kpj@gmail.com')  // Recipient email
//       ..subject = 'New Feedback Submitted: $referralId'
//       ..text = 'Feedback Type: $feedback\n'
//           'Title: ${feedbackTitle.text}\n'
//           'Description: ${feedbackDescription.text}';
//
//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent. \n${e.toString()}');
//     }
//   }
//
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
//                     feedback = value as String?;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: feedbackTitle,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Enter Feedback Title';
//                     } else {
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
//                     if (value!.isEmpty) {
//                       return 'Enter description';
//                     } else {
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
//                   onPressed: () {
//                     saveFeedback();
//                   },
//                   child: Text('Save Feedback'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:typed_data';

import 'package:agent_referral/admin/controller/admin_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PackageCreateScreen extends StatefulWidget {
  const PackageCreateScreen({super.key});

  @override
  State<PackageCreateScreen> createState() => _PackageCreateScreenState();
}

class _PackageCreateScreenState extends State<PackageCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PackageController _packageController = PackageController();

  late String title;
  late String description;
  Uint8List? _image;


  selectImage() async{
    Uint8List im = await _packageController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  _savePackageDetail() async{
    EasyLoading.show(status: 'PLEASE WAIT');
    String packageId = Uuid().v4();
    if(_formKey.currentState!.validate()){
      await _packageController.createPackage(title, description, _image, packageId).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      },);
    }else{
      print('Not updated');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: () {
          selectImage();
        },
        icon: Icon(Icons.browse_gallery),
        label: Text('Browse Gallery'));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Title Name';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(label: Text('Title')),
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [Colors.red.shade100,Colors.blue.shade200])
                ),
                height: 300,
                width: double.infinity,
                alignment: Alignment.center,
                child: _image != null ? Image.memory(_image!, fit: BoxFit.cover,):content,
              ),
              SizedBox(height: 16,),
              TextFormField(
                maxLength: 800,
                maxLines: 4,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),label: Text('Description')),
                onChanged: (value) {
                  description = value;
                },
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Package Description';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton.icon(onPressed: () {
                _savePackageDetail;
              }, icon: Icon(Icons.add), label: Text('Add Package'))

            ]),
          ),
        ),
      ),
    );
  }
}
