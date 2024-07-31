import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientFamilyScreen extends StatefulWidget {
  const PatientFamilyScreen({super.key});

  @override
  State<PatientFamilyScreen> createState() => _PatientFamilyScreenState();
}

class _PatientFamilyScreenState extends State<PatientFamilyScreen> {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<String> _sexOption = ['Male','Female','Others'];
    String? sex;
    List<String> _nationalityOption = ['Malaysian', 'Foreigner', 'Others'];
    String? nationality;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(label: Text('Name')),
                ),
                TextFormField(
                  onChanged: (value) {},
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
                      nationality = value;
                    });
                  },
                ),
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
                  decoration: InputDecoration(label: Text('Contact Number')),
                ),
                TextFormField(
                  onChanged: (value) {

                  },
                  decoration: InputDecoration(label: Text('Age')),
                ),
                DropdownButtonFormField(hint: Text('Select Gender'),items: _sexOption.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value,child: Text(value));
                }).toList(), onChanged: (value) {
                  setState(() {
                    sex = value;
                  });
                },)

              ],
            ),
          ),
        ),
      );
    }

}

