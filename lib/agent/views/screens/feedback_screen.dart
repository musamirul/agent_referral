import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  List<String> _feedbackOption = [
    'Concern',
    'Sugestion',
    'Improvement',
    'Constructive'
  ];

  void saveFeedback() async{
    if(_formKey.currentState!.validate()){
      final referralId = Uuid().v4();
      await _firestore.collection('feedback').doc(referralId).set({
        'agentId':_auth.currentUser!.uid,
        'feedback':feedback,
        'title':title,
        'description':description,
      }).whenComplete(() {

      },);
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
                    feedback = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Feedback Title';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(label: Text('Feedback Title')),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter description';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    description = value;
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
                    }, child: Text('Save Feedback')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
