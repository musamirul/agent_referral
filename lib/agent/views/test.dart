// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // class Test extends StatelessWidget {
// // //   Test({super.key});
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //
// // //   void retrieveOnce(){
// // //     _firestore.collection('referral').get().then((value) {
// // //       value.docs.forEach((element) {
// // //         print(element.data());
// // //       },);
// // //     },);
// // //   }
// // //
// // //   void retrieveDoc(){
// // //     _auth.currentUser!.uid;
// // //     _firestore.collection('referral').where("agentId", isEqualTo: _auth.currentUser!.uid).where("status",isEqualTo: "Pending").get().then((value) {
// // //       value.docs.forEach((element) {
// // //         print(element.id);
// // //         print(element.data());
// // //       });
// // //     },);
// // //   }
// // //
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(child: ElevatedButton(child: Text('Execute Command'),onPressed: () {
// // //         retrieveDoc();
// // //       },)),
// // //     );
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:uuid/uuid.dart';
// // import 'package:mailer/mailer.dart';
// // import 'package:mailer/smtp_server.dart';
// //
// // class FeedbackScreen extends StatefulWidget {
// //   FeedbackScreen({super.key});
// //
// //   @override
// //   State<FeedbackScreen> createState() => _FeedbackScreenState();
// // }
// //
// // class _FeedbackScreenState extends State<FeedbackScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //
// //   String? feedback;
// //   String? title;
// //   String? description;
// //   TextEditingController feedbackTitle = TextEditingController();
// //   TextEditingController feedbackDescription = TextEditingController();
// //
// //   List<String> _feedbackOption = [
// //     'Concern',
// //     'Suggestion',
// //     'Improvement',
// //     'Constructive'
// //   ];
// //
// //   void saveFeedback() async {
// //     if (_formKey.currentState!.validate()) {
// //       final referralId = Uuid().v4();
// //       await _firestore.collection('feedback').doc(referralId).set({
// //         'agentId': _auth.currentUser!.uid,
// //         'feedback': feedback,
// //         'title': feedbackTitle.text,
// //         'description': feedbackDescription.text,
// //       }).whenComplete(() {
// //         feedbackTitle.clear();
// //         feedbackDescription.clear();
// //       });
// //
// //       // Send email after saving feedback
// //       sendEmail(referralId);
// //     }
// //   }
// //
// //   void sendEmail(String referralId) async {
// //     String username = 'musamirul.kpj@gmail.com';  // Your email address
// //     String password = 'qwerty30';    // Your email password
// //
// //     final smtpServer = gmail(username, password);
// //
// //     final message = Message()
// //       ..from = Address(username, 'ameirul')
// //       ..recipients.add('musamirul.kpj@gmail.com')  // Recipient email
// //       ..subject = 'New Feedback Submitted: $referralId'
// //       ..text = 'Feedback Type: $feedback\n'
// //           'Title: ${feedbackTitle.text}\n'
// //           'Description: ${feedbackDescription.text}';
// //
// //     try {
// //       final sendReport = await send(message, smtpServer);
// //       print('Message sent: ' + sendReport.toString());
// //     } on MailerException catch (e) {
// //       print('Message not sent. \n${e.toString()}');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Feedback Form'),
// //         backgroundColor: Colors.blue,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: SingleChildScrollView(
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               children: [
// //                 DropdownButtonFormField(
// //                   hint: Text('Select Feedback'),
// //                   items: _feedbackOption.map<DropdownMenuItem<String>>((value) {
// //                     return DropdownMenuItem(value: value, child: Text(value));
// //                   }).toList(),
// //                   onChanged: (value) {
// //                     feedback = value as String?;
// //                   },
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 TextFormField(
// //                   controller: feedbackTitle,
// //                   validator: (value) {
// //                     if (value!.isEmpty) {
// //                       return 'Enter Feedback Title';
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                   decoration: InputDecoration(label: Text('Feedback Title')),
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 TextFormField(
// //                   controller: feedbackDescription,
// //                   validator: (value) {
// //                     if (value!.isEmpty) {
// //                       return 'Enter description';
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                   maxLines: 8,
// //                   maxLength: 800,
// //                   decoration: InputDecoration(
// //                       label: Text('Description'),
// //                       border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(10))),
// //                 ),
// //                 SizedBox(height: 30,),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     saveFeedback();
// //                   },
// //                   child: Text('Save Feedback'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:typed_data';
//
// import 'package:agent_referral/admin/controller/admin_package_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';
//
// class PackageCreateScreen extends StatefulWidget {
//   const PackageCreateScreen({super.key});
//
//   @override
//   State<PackageCreateScreen> createState() => _PackageCreateScreenState();
// }
//
// class _PackageCreateScreenState extends State<PackageCreateScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final PackageController _packageController = PackageController();
//
//   late String title;
//   late String description;
//   Uint8List? _image;
//
//
//   selectImage() async{
//     Uint8List im = await _packageController.pickStoreImage(ImageSource.gallery);
//     setState(() {
//       _image = im;
//     });
//   }
//
//   _savePackageDetail() async{
//     EasyLoading.show(status: 'PLEASE WAIT');
//     String packageId = Uuid().v4();
//     if(_formKey.currentState!.validate()){
//       await _packageController.createPackage(title, description, _image, packageId).whenComplete(() {
//         EasyLoading.dismiss();
//         setState(() {
//           _formKey.currentState!.reset();
//           _image = null;
//         });
//       },);
//     }else{
//       print('Not updated');
//       EasyLoading.dismiss();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget content = TextButton.icon(
//         onPressed: () {
//           selectImage();
//         },
//         icon: Icon(Icons.browse_gallery),
//         label: Text('Browse Gallery'));
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(children: [
//               TextFormField(
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Please Enter Title Name';
//                   }else{
//                     return null;
//                   }
//                 },
//                 onChanged: (value) {
//                   title = value;
//                 },
//                 decoration: InputDecoration(label: Text('Title')),
//                 style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: LinearGradient(colors: [Colors.red.shade100,Colors.blue.shade200])
//                 ),
//                 height: 300,
//                 width: double.infinity,
//                 alignment: Alignment.center,
//                 child: _image != null ? Image.memory(_image!, fit: BoxFit.cover,):content,
//               ),
//               SizedBox(height: 16,),
//               TextFormField(
//                 maxLength: 800,
//                 maxLines: 4,
//                 decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),label: Text('Description')),
//                 onChanged: (value) {
//                   description = value;
//                 },
//                 validator: (value) {
//                   if(value!.isEmpty){
//                     return 'Please Enter Package Description';
//                   }else{
//                     return null;
//                   }
//                 },
//               ),
//               SizedBox(height: 10,),
//               ElevatedButton.icon(onPressed: () {
//                 _savePackageDetail;
//               }, icon: Icon(Icons.add), label: Text('Add Package'))
//
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:agent_referral/provider/referral_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';
//
// class UploadReferralScreen extends StatefulWidget {
//   @override
//   _UploadReferralScreenState createState() => _UploadReferralScreenState();
// }
//
// class _UploadReferralScreenState extends State<UploadReferralScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//   final TextEditingController _fileExtensionController = TextEditingController();
//   String? _fileName;
//   List<PlatformFile>? _paths;
//   List<File> _files = [];
//   List<String> _fileUrlList = [];
//   String? _directoryPath;
//   String? _extension;
//   bool _isLoading = false;
//   bool _userAborted = false;
//   bool _multiPick = false;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _fileExtensionController.addListener(() {
//       _extension = _fileExtensionController.text;
//     });
//   }
//
//   void _pickFiles() async {
//     _resetState();
//     try {
//       _directoryPath = null;
//       _paths = (await FilePicker.platform.pickFiles(
//         allowMultiple: _multiPick,
//         onFileLoading: (FilePickerStatus status) => print(status),
//         allowedExtensions: (_extension?.isNotEmpty ?? false)
//             ? _extension?.replaceAll(' ', '').split(',')
//             : null,
//         type: _extension == null ? FileType.any : FileType.custom,
//       ))?.files;
//
//       if (_paths != null) {
//         _files = _paths!.map((file) => File(file.path!)).toList();
//       }
//     } on PlatformException catch (e) {
//       _logException('Unsupported operation: ${e.toString()}');
//     } catch (e) {
//       _logException(e.toString());
//     }
//     if (!mounted) return;
//     setState(() {
//       _isLoading = false;
//       _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
//       _userAborted = _paths == null;
//     });
//   }
//
//   Future<void> _uploadFiles() async {
//     if (_files.isEmpty) {
//       _showMessage('No files selected to upload');
//       return;
//     }
//
//     final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context, listen: false);
//
//     EasyLoading.show(status: 'Saving Document');
//     try {
//       for (var file in _files) {
//         Reference ref = _storage.ref().child('patientDocument/${Uuid().v4()}');
//         UploadTask uploadTask = ref.putFile(file);
//         TaskSnapshot taskSnapshot = await uploadTask;
//         String fileURL = await taskSnapshot.ref.getDownloadURL();
//
//         setState(() {
//           _fileUrlList.add(fileURL);
//         });
//       }
//       _referralProvider.getFormData(fileUrlList: _fileUrlList);
//       EasyLoading.dismiss();
//       _showMessage('Files uploaded successfully!');
//     } catch (e) {
//       EasyLoading.dismiss();
//       _logException('Failed to upload files: ${e.toString()}');
//     }
//   }
//
//   void _logException(String message) {
//     print(message);
//     _showMessage(message);
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   void _resetState() {
//     if (!mounted) return;
//     setState(() {
//       _isLoading = true;
//       _directoryPath = null;
//       _fileName = null;
//       _paths = null;
//       _files = [];
//       _userAborted = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       scaffoldMessengerKey: _scaffoldMessengerKey,
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text(
//             'Please attach a referral letter / memo or imaging film/test results',
//             style: TextStyle(fontSize: 12),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Configuration',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Wrap(
//                   alignment: WrapAlignment.start,
//                   runAlignment: WrapAlignment.start,
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   direction: Axis.horizontal,
//                   spacing: 10.0,
//                   runSpacing: 10.0,
//                   children: [
//                     ConstrainedBox(
//                       constraints: const BoxConstraints.tightFor(width: 400.0),
//                       child: SwitchListTile.adaptive(
//                         title: Text('Pick multiple files'),
//                         onChanged: (bool value) => setState(() => _multiPick = value),
//                         value: _multiPick,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.0),
//                 Divider(),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'Actions',
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20.0),
//                   child: Wrap(
//                     spacing: 10.0,
//                     runSpacing: 10.0,
//                     children: <Widget>[
//                       SizedBox(
//                         width: 120,
//                         child: FloatingActionButton.extended(
//                           heroTag: "btn1",
//                           onPressed: _pickFiles,
//                           label: Text(_multiPick ? 'Pick files' : 'Pick file'),
//                           icon: const Icon(Icons.description),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 120,
//                         child: FloatingActionButton.extended(
//                           heroTag: "btn2",
//                           onPressed: _uploadFiles,
//                           label: const Text('Save'),
//                           icon: const Icon(Icons.save),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'File Picker Result',
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Builder(
//                   builder: (BuildContext context) => _isLoading
//                       ? Row(
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 40.0),
//                             child: const CircularProgressIndicator(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       : _userAborted
//                       ? Row(
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: SizedBox(
//                             width: 300,
//                             child: ListTile(
//                               leading: Icon(Icons.error_outline),
//                               contentPadding: EdgeInsets.symmetric(vertical: 40.0),
//                               title: const Text('User has aborted the dialog'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       : _directoryPath != null
//                       ? ListTile(
//                     title: const Text('Directory path'),
//                     subtitle: Text(_directoryPath!),
//                   )
//                       : _paths != null
//                       ? Container(
//                     padding: const EdgeInsets.symmetric(vertical: 20.0),
//                     height: MediaQuery.of(context).size.height * 0.50,
//                     child: Scrollbar(
//                       child: ListView.separated(
//                         itemCount: _paths?.length ?? 0,
//                         itemBuilder: (BuildContext context, int index) {
//                           final bool isMultiPath = _paths != null && _paths!.isNotEmpty;
//                           final String name = 'File $index: ' +
//                               (isMultiPath
//                                   ? _paths!.map((e) => e.name).toList()[index]
//                                   : _fileName ?? '...');
//                           final path = kIsWeb
//                               ? null
//                               : _paths!.map((e) => e.path).toList()[index].toString();
//
//                           return ListTile(
//                             title: Text(name),
//                             subtitle: Text(path ?? ''),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) => const Divider(),
//                       ),
//                     ),
//                   )
//                       : const SizedBox(),
//                 ),
//                 SizedBox(height: 40.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//       builder: EasyLoading.init(),
//     );
//   }
// }


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';
//
// class PackageDetail extends StatelessWidget {
//   const PackageDetail({super.key, required this.packageId});
//   final String packageId;
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference package = FirebaseFirestore.instance.collection('package');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: package.doc(packageId).get(),
//       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text("Something went wrong"));
//         }
//
//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Center(child: Text("Document does not exist"));
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//           snapshot.data!.data() as Map<String, dynamic>;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 data['name'],
//                 style: TextStyle(
//                     letterSpacing: 2,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.blue,
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 650,
//                     width: double.infinity,
//                     child: CachedNetworkImage(
//                       imageUrl: data['image'],
//                       imageBuilder: (context, imageProvider)  => Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover
//                           ),
//                         ),
//                       ),
//                       placeholder: (context, url) => Shimmer(
//                         duration: Duration(seconds: 2), // Default value
//                         color: Colors.grey, // Default value
//                         colorOpacity: 0.3, // Default value
//                         enabled: true, // Default value
//                         direction: ShimmerDirection.fromLTRB(),
//                         child: Container(
//                           color: Colors.grey[300],
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(data['description']),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
// class PatientDetail extends StatelessWidget {
//   const PatientDetail({super.key, required this.referralId});
//
//   final String referralId;
//
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     CollectionReference patient = FirebaseFirestore.instance.collection('referral');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: patient.doc(referralId).get(),
//       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           List<String> urls = List<String>.from(data['fileUrlList']);
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Patient Detail',
//                 style: TextStyle(
//                   letterSpacing: 2,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.blue,
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Text(
//                       data['patientName'],
//                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(1.0),
//                     child: Text(
//                       data['patientIc'],
//                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Divider(
//                       thickness: 0.7,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Text('Patient & Family Information'),
//                   ListTile(
//                     leading: Icon(Icons.phone),
//                     title: Text(data['patientPhone']),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.flag),
//                     title: Text(data['patientNationality']),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.safety_divider),
//                     title: Text(data['patientGender']),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.home),
//                     title: Text(data['patientAddress']),
//                   ),
//                   Divider(thickness: 2, color: Colors.grey.shade200),
//                   Text('Insurance Information'),
//                   ListTile(
//                     leading: Icon(Icons.health_and_safety),
//                     title: Text(data['patientIns']),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.shield),
//                     title: Text(data['patientInsNumber']),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.policy),
//                     title: Text(data['patientPolicyPeriod']),
//                   ),
//                   Divider(thickness: 2, color: Colors.grey.shade200),
//                   Text('Reason For Referral'),
//                   Column(
//                     children: [
//                       Text('Date Accident / Injury: ' +
//                           data['patientDateAccident'] +
//                           ' ' +
//                           data['patientTimeAccident']),
//                     ],
//                   ),
//                   Divider(thickness: 2, color: Colors.grey.shade200),
//                   Text('Patient Document'),
//                   ElevatedButton(
//                     onPressed: () => downloadAllFiles(urls, context),
//                     child: Text('Download All Documents'),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: urls.length,
//                     itemBuilder: (context, index) {
//                       String url = urls[index];
//                       String fileName = url.split('/').last;
//                       return ListTile(
//                         title: Text(fileName, maxLines: 2),
//                         trailing: IconButton(
//                           icon: Icon(Icons.download),
//                           onPressed: () {
//                             downloadFile(url, fileName, context);
//                             print(url);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
//
//   Future<void> downloadFile(String url, String fileName, BuildContext context) async {
//     try {
//       final status = await Permission.storage.request();
//       if (status.isGranted) {
//         final directory = await getExternalStorageDirectory();
//         final filePath = '${directory!.path}/$fileName';
//         final file = File(filePath);
//
//         final ref = FirebaseStorage.instance.refFromURL(url);
//         await ref.writeToFile(file);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Downloaded $fileName')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Permission denied')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to download file: $e')),
//       );
//     }
//   }
//
//   Future<void> downloadAllFiles(List<String> urls, BuildContext context) async {
//     for (String url in urls) {
//       String fileName = url.split('/').last;
//       await downloadFile(url, fileName, context);
//       print(fileName);
//     }
//   }
// }

import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

/// Test mailer by sending email to yourself
void main(List<String> rawArgs) async {
  var args = parseArgs(rawArgs);

  if (args[verboseArg] as bool) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  var username = args.rest[0];
  if (username.endsWith('@gmail.com')) {
    username = username.substring(0, username.length - 10);
  }

  var tos = args[toArgs] as List<String>? ?? [];
  if (tos.isEmpty) {
    tos.add(username.contains('@') ? username : '$username@gmail.com');
  }

  // If you want to use an arbitrary SMTP server, go with `SmtpServer()`.
  // The gmail function is just for convenience. There are similar functions for
  // other providers.
  final smtpServer = gmail(username, args.rest[1]);

  Iterable<Address> toAd(Iterable<String>? addresses) =>
      (addresses ?? []).map((a) => Address(a));

  Iterable<Attachment> toAt(Iterable<String>? attachments) =>
      (attachments ?? []).map((a) => FileAttachment(File(a)));

  // Create our message.
  final message = Message()
    ..from = Address('$username@gmail.com', 'My name 😀')
    ..recipients.addAll(toAd(tos))
    ..ccRecipients.addAll(toAd(args[ccArgs] as Iterable<String>?))
    ..bccRecipients.addAll(toAd(args[bccArgs] as Iterable<String>?))
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"
    ..attachments.addAll(toAt(args[attachArgs] as Iterable<String>?));

  try {
    final sendReport =
    await send(message, smtpServer, timeout: Duration(seconds: 15));
    print('Message sent: $sendReport');
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  print('Now sending using a persistent connection');
  var connection =
  PersistentConnection(smtpServer, timeout: Duration(seconds: 15));
  // Send multiple mails on one connection:
  try {
    for (var i = 0; i < 3; i++) {
      message.subject =
      'Test Dart Mailer library :: 😀 :: ${DateTime.now()} / $i';
      final sendReport = await connection.send(message);
      print('Message sent: $sendReport');
    }
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  } catch (e) {
    print('Other exception: $e');
  } finally {
    await connection.close();
  }
}

const toArgs = 'to';
const attachArgs = 'attach';
const ccArgs = 'cc';
const bccArgs = 'bcc';
const verboseArg = 'verbose';

ArgResults parseArgs(List<String> rawArgs) {
  var parser = ArgParser()
    ..addFlag('verbose', abbr: 'v', help: 'Display logging output.')
    ..addMultiOption(toArgs,
        abbr: 't',
        help: 'The addresses to which the email is sent.\n'
            'If omitted, then the email is sent to the sender.')
    ..addMultiOption(attachArgs,
        abbr: 'a', help: 'Paths to files which will be attached to the email.')
    ..addMultiOption(ccArgs, help: 'The cc addresses for the email.')
    ..addMultiOption(bccArgs, help: 'The bcc addresses for the email.');

  var args = parser.parse(rawArgs);
  if (args.rest.length != 2) {
    showUsage(parser);
    exit(1);
  }

  var attachments = args[attachArgs] as Iterable<String>? ?? [];
  for (var f in attachments) {
    var attachFile = File(f);
    if (!attachFile.existsSync()) {
      showUsage(parser, 'Failed to find file to attach: ${attachFile.path}');
      exit(1);
    }
  }
  return args;
}

void showUsage(ArgParser parser, [String? message]) {
  if (message != null) {
    print(message);
    print('');
  }
  print('Usage: send_gmail [options] <username> <password>');
  print('');
  print(parser.usage);
  print('');
  print('If you have Google\'s "app specific passwords" enabled,');
  print('you need to use one of those for the password here.');
  print('');
}