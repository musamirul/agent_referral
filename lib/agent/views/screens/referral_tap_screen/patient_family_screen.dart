import 'package:agent_referral/provider/referral_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientFamilyScreen extends StatefulWidget {
  const PatientFamilyScreen({super.key});

  @override
  State<PatientFamilyScreen> createState() => _PatientFamilyScreenState();
}

class _PatientFamilyScreenState extends State<PatientFamilyScreen> with AutomaticKeepAliveClientMixin{

    List<String> _sexOption = ['Male','Female','Others'];
    String? sex;
    List<String> _nationalityOption = ['Malaysian', 'Foreigner', 'Others'];
    String? nationality;

    @override
    // TODO: implement wantKeepAlive
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
      super.build(context);
      ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Name';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientName: value);
                  },
                  decoration: InputDecoration(label: Text('Name')),
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter I/C or Passport Number';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientIc: value);
                  },
                  decoration:
                  InputDecoration(label: Text('I/C or Passport Number')),
                ),
                DropdownButtonFormField(
                  hint: Text('Select Nationality'),
                  items: _nationalityOption.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _referralProvider.getFormData(patientNationality: value);
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Home Address';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientAddress: value);
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
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Contact Number';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientPhone: value);
                  },
                  decoration: InputDecoration(label: Text('Contact Number')),
                ),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter Age';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientAge: value);
                  },
                  decoration: InputDecoration(label: Text('Age')),
                ),
                DropdownButtonFormField(hint: Text('Select Gender'),items: _sexOption.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value,child: Text(value));
                }).toList(), onChanged: (value) {
                  setState(() {
                    _referralProvider.getFormData(patientGender: value);
                  });
                },)

              ],
            ),
          ),
        ),
      );
    }



}

