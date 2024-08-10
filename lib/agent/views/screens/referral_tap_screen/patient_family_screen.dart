import 'package:agent_referral/provider/referral_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientFamilyScreen extends StatefulWidget {
  const PatientFamilyScreen({super.key});

  @override
  State<PatientFamilyScreen> createState() => _PatientFamilyScreenState();
}

class _PatientFamilyScreenState extends State<PatientFamilyScreen>
    with AutomaticKeepAliveClientMixin {

  final _formKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                  decoration: InputDecoration(label: Text('Name')),
                  textInputAction: TextInputAction.next,
                ),
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
                  decoration: InputDecoration(label: Text('I/C or Passport Number')),
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField<String>(
                  hint: Text('Select Nationality'),
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
                    decoration: InputDecoration(label: Text('Nationality')),
                    textInputAction: TextInputAction.next,
                  ),
                SizedBox(height: 20),
                TextFormField(
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
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Home Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                  decoration: InputDecoration(label: Text('Contact Number')),
                  textInputAction: TextInputAction.next,
                ),
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
                  decoration: InputDecoration(label: Text('Age')),
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField<String>(
                  hint: Text('Select Gender'),
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
      ),
    );
  }
}