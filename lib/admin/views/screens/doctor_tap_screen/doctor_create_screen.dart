import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class DoctorCreateScreen extends StatefulWidget {
  const DoctorCreateScreen({super.key});

  @override
  State<DoctorCreateScreen> createState() => _DoctorCreateScreenState();
}

class _DoctorCreateScreenState extends State<DoctorCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController doctorName = TextEditingController();
  TextEditingController doctorSpeciality = TextEditingController();
  String? type;

  List<String> _typeOption = ['Visiting', 'Resident', 'Sessional'];

  void saveConsultant() async {
    if (_formKey.currentState!.validate()) {
      final doctorId = Uuid().v4();
      await _firestore.collection('doctors').doc(doctorId).set({
        'name': doctorName.text,
        'speciality': doctorSpeciality.text,
        'type': type,
      }).whenComplete(
        () {
          doctorName.clear();
          doctorSpeciality.clear();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Doctor Name';
                    } else {
                      return null;
                    }
                  },
                  controller: doctorName,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Doctor Name',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Doctor Speciality';
                    } else {
                      return null;
                    }
                  },
                  controller: doctorSpeciality,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Doctor Speciality',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20,
                ),
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
                  hint: Text('Select Doctor Residency'),
                  items: _typeOption.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    type = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, fixedSize: Size(300, 30)),
                  onPressed: () {
                    saveConsultant();
                  },
                  label: Text('Add Doctor', style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.add,color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
