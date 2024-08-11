import 'package:agent_referral/provider/referral_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientFamilyScreen extends StatefulWidget {
  const PatientFamilyScreen({super.key});

  @override
  State<PatientFamilyScreen> createState() => _PatientFamilyScreenState();
}

class _PatientFamilyScreenState extends State<PatientFamilyScreen>
    with AutomaticKeepAliveClientMixin {

  List<String> _sexOption = ['Male', 'Female', 'Others'];
  String? sex;

  List<String> _nationalityOption = ['Malaysian', 'Foreigner', 'Others'];
  String? nationality;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientName: value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Name',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter I/C or Passport Number';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientIc: value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'IC or Passport Number',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                hint: Text('Select Nationality'),
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
                items: _nationalityOption.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    nationality = value;
                    _referralProvider.getFormData(patientNationality: nationality);
                  });
                },
              ),
              if (nationality == 'Foreigner' || nationality == 'Others')
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Nationality';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _referralProvider.getFormData(patientNationality: value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Nationality',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.house),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Home Address',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Home Address';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientAddress: value);
                },
                maxLength: 800,
                maxLines: 3,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Contact Number';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientPhone: value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone_android),
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Age';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientAge: value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Age',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                hint: Text('Select Gender'),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Gender',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                items: _sexOption.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    sex = value;
                    _referralProvider.getFormData(patientGender: sex);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}