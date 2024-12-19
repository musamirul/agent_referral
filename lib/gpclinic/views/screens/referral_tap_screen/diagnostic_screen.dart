import 'package:agent_referral/gpclinic/controller/diagnostic_referral_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class DiagnosticScreen extends StatefulWidget {
  const DiagnosticScreen({super.key});

  @override
  State<DiagnosticScreen> createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DiagnosticReferralController _diagnosticReferralController =
      DiagnosticReferralController();

  final List<String> _sexOption = ['Male', 'Female', 'Others'];
  String? sex;

  final List<String> _nationalityOption = ['Malaysian', 'Foreigner', 'Others'];
  String? nationality;

  late String foreignNationality;
  late String name;
  late String identity;
  late String phone;
  late String address;

  _saveDiagnosticReferral() async {
    EasyLoading.show(status: 'PLEASE WAIT');
    String referralId = Uuid().v4();
    if (_formKey.currentState!.validate()) {
      await _diagnosticReferralController.createDiagnostic(name, identity,
          phone, nationality!, foreignNationality, address, sex!, referralId);
      EasyLoading.dismiss();
      setState(() {
        _formKey.currentState!.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/header.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.7),
                  Colors.orange.withOpacity(0.6)
                ],begin: Alignment.topCenter,end: Alignment.bottomCenter
              ),
            ),
          ))
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Patient Information',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Patient Name',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10,
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
                    identity = value;
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
                SizedBox(
                  height: 10,
                ),
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
                      nationality = value!;
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
                      foreignNationality = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Nationality',
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
                  onChanged: (value) {
                    address = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Home Address';
                    } else {
                      return null;
                    }
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
                    phone = value;
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
                SizedBox(
                  height: 10,
                ),
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
                      sex = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      fixedSize: Size(300, 30),
                    ),
                    onPressed: () {
                      _saveDiagnosticReferral();
                    },
                    label: Text(
                      'Add Referral',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
