import 'package:agent_referral/provider/referral_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:intl/intl.dart';

class ReasonScreen extends StatefulWidget {
  const ReasonScreen({super.key});

  @override
  State<ReasonScreen> createState() => _ReasonScreenState();
}

class _ReasonScreenState extends State<ReasonScreen> with AutomaticKeepAliveClientMixin{
  // List<DateTime?> _date = [DateTime.now().add(const Duration(days: 1))];
  List<String> _driverType = ['Driver','Pillion Rider','Passenger','Other'];
  List<String> _licence = ['Yes','No'];
  List<String> _transportation = ['Self Transport','Ambulance'];
  List<DateTime?>? newDate;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Patient Complaints';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  _referralProvider.getFormData(patientComplaints: value);
                },
                decoration: InputDecoration(label: Text('Complaints / History')),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text('Date of Accident / Injury : '),
                  TimePickerSpinnerPopUp(
                    mode: CupertinoDatePickerMode.date,
                    initTime: DateTime.now(),
                    timeFormat: 'dd/MM/yyyy',
                    onChange: (dateTime) {
                      _referralProvider.getFormData(patientDateAccident: DateFormat('dd/MM/yyy').format(dateTime));
                    }
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text('Time of Accident / Injury : '),
                  TimePickerSpinnerPopUp(
                    mode: CupertinoDatePickerMode.time,
                    initTime: DateTime.now(),
                    timeFormat: 'HH:mm:ss',
                    onChange: (dateTime) {
                      _referralProvider.getFormData(patientTimeAccident: DateFormat('HH:mm:ss').format(dateTime));
                    },
                  )
                ],
              ),
              DropdownButtonFormField(hint: Text('Select Driving Type'),items: _driverType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(child: Text(value),value: value,);
              }).toList(), onChanged: (value) {
                _referralProvider.getFormData(driverType: value);
              },),
              DropdownButtonFormField(hint: Text('have licence?'),items: _licence.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(child: Text(value),value: value,);
              }).toList(), onChanged: (value) {
                _referralProvider.getFormData(licence: value);
              },),
              SizedBox(height: 5,),
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter Referral Reasons';
                  }else{
                    return null;
                  }
                },
                maxLength: 800,
                maxLines: 2,
                onChanged: (value) {
                  _referralProvider.getFormData(reasonReferral: value);
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),label: Text('Reason for referral/diagnosis')),
              ),
              Text('**Subject to availability,entitlement,& doctor’s recommendation.',style: TextStyle(color: Colors.red, fontSize: 12),),
              TextFormField(
                onChanged: (value) {
                  _referralProvider.getFormData(requestSpeciality: value);
                },
                decoration: InputDecoration(label: Text('Requested Specialist / Speciality')),
              ),
              Text('**An ambulance service fee applies.',style: TextStyle(fontSize: 12,color: Colors.red),textAlign: TextAlign.left),
              DropdownButtonFormField(hint: Text('Select Transportation'),items: _transportation.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(child: Text(value), value: value,);
              }).toList(), onChanged: (value) {
                _referralProvider.getFormData(transportation: value);
              },),
              TextFormField(
                onChanged: (value) {
                  _referralProvider.getFormData(requestTreatment: value);
                },
                decoration: InputDecoration(label: Text('Test /Procedures /Imaging /Treatments')),
              )
            ],
          ),
        ),
      ),
    );
  }


}
