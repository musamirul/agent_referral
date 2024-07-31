import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _payOption = ['YES','NO'];
  List<String> _insuranceOption = ['AIA','PRUDENTIAL','GREAT EASTERN','PM CARE', 'CUEPACS', 'OTHERS'];
  List<String> _bedOption = ['None','Single','Double','Premier','HDU','Other'];
  String? bed;
  String? selfPay;
  String? insuranceType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButtonFormField(hint: Text('Self Pay?'),items: _payOption.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(child: Text(value),value: value,);
            }).toList(), onChanged: (value) {
              setState(() {
                selfPay = value;
              });

            },),
            SizedBox(height: 20,),
            if(selfPay=='NO')
              Column(
                children: [
                  DropdownButtonFormField(hint: Text('Select Insurance Type'),items: _insuranceOption.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(child: Text(value),value: value,);
                  }).toList(), onChanged: (value) {
                    insuranceType = value;
                  },),
                  TextFormField(
                    onChanged: (value) {

                    },
                    decoration: InputDecoration(label: Text('Insurance Policy Number')),
                  ),
                  TextFormField(onChanged: (value) {

                  },decoration: InputDecoration(label: Text('Policy Period')),
                  ),


                ],
              ),
            SizedBox(height: 20,),
            DropdownButtonFormField(hint: Text('Requested Bed'),items: _bedOption.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(child: Text(value),value: value,);
            }).toList(), onChanged: (value) {
              setState(() {
                bed = value;
              });
            },)



          ],
        ),
      ),
    );
  }
}
