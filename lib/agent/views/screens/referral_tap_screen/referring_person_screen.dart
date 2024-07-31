import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReferringPersonScreen extends StatefulWidget {
  const ReferringPersonScreen({super.key});

  @override
  State<ReferringPersonScreen> createState() => _ReferringPersonScreenState();
}

class _ReferringPersonScreenState extends State<ReferringPersonScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _referralOption = ['Patient','Relatives','Agent','Doctor','Other'];
  String? referral;
  List<String> _locationOption = ['Home','Work Place', 'Health Care Centre','Organization'];
  String? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(hint: Text('Select Referring Person'),items: _referralOption.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value,child: Text(value));
              }).toList(), onChanged: (value) {
                referral = value;
              },),
              TextFormField(
                onChanged: (value) {},
                decoration: InputDecoration(label: Text('Name')),
              ),
              DropdownButtonFormField(hint: Text('Select Address Location'),items: _locationOption.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(child: Text(value),value: value,);
              }).toList(), onChanged: (value) {

              },),
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (value) {

                },
                maxLength: 800,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Home Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              TextFormField(
                onChanged: (value) {

                },
                decoration: InputDecoration(label: Text('Email')),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
