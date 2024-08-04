import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  List<String> _typeOption = [
    'Visiting','Resident','Sessional'
  ];

  void saveConsultant() async{
    if(_formKey.currentState!.validate()){
      final doctorId = Uuid().v4();
      await _firestore.collection('doctors').doc(doctorId).set({
        'name' : doctorName.text,
        'speciality' : doctorSpeciality.text,
        'type' : type,
      }).whenComplete(() {
        doctorName.clear();
        doctorSpeciality.clear();
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Doctor Name';
                    }else{
                      return null;
                    }
                  },
                  controller: doctorName,
                  decoration: InputDecoration(label: Text('Doctor Name')),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Doctor Speciality';
                    }else{
                      return null;
                    }
                  },
                  controller: doctorSpeciality,
                  decoration: InputDecoration(label: Text('Doctor Speciality')),
                  maxLines: 2,
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(hint: Text('Select Doctor Residency'),items: _typeOption.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(child: Text(value),value: value,);
                }).toList(), onChanged: (value) {
                  type = value;
                },),
                SizedBox(height: 20,),
                ElevatedButton.icon(onPressed: () {
                  saveConsultant();
                }, label: Text('Add Doctor'),
                icon: Icon(Icons.add),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
