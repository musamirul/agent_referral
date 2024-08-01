import 'package:agent_referral/agent/views/agent_main_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/insurance_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/patient_family_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/reasons_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/referring_person_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/upload_referral_screen.dart';
import 'package:agent_referral/provider/referral_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PatientRegisterScreen extends StatelessWidget {
  PatientRegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
    return DefaultTabController(
        length: 5,
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade500,
              elevation: 0,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text('Agent'),
                  ),
                  Tab(
                    child: Text('Patient'),
                  ),
                  Tab(
                    child: Text('Ins'),
                  ),
                  Tab(
                    child: Text('Reason'),
                  ),
                  Tab(
                    child: Text('Upload'),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              ReferringPersonScreen(),
              PatientFamilyScreen(),
              InsuranceScreen(),
              ReasonScreen(),
              UploadReferralScreen(),
            ]),
            bottomSheet: Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    final referralId = Uuid().v4();
                    await _firestore.collection('referral').doc(referralId).set({
                      'agentId' : _auth.currentUser!.uid,
                      'referralId' :referralId,
                      'status':'Pending',
                      'referralPerson':_referralProvider.referralData['referralPerson'],
                      'referralName':_referralProvider.referralData['referralName'],
                      'referralLocation':_referralProvider.referralData['referralLocation'],
                      'referralAddress':_referralProvider.referralData['referralAddress'],
                      'referralEmail':_referralProvider.referralData['referralEmail'],
                      'patientName':_referralProvider.referralData['patientName'],
                      'patientIc':_referralProvider.referralData['patientIc'],
                      'patientNationality':_referralProvider.referralData['patientNationality'],
                      'patientAddress':_referralProvider.referralData['patientAddress'],
                      'patientPhone':_referralProvider.referralData['patientPhone'],
                      'patientAge':_referralProvider.referralData['patientAge'],
                      'patientGender':_referralProvider.referralData['patientGender'],
                      'patientPayment':_referralProvider.referralData['patientPayment'],
                      'patientIns':_referralProvider.referralData['patientIns'],
                      'patientInsNumber':_referralProvider.referralData['patientInsNumber'],
                      'patientPolicyPeriod':_referralProvider.referralData['patientPolicyPeriod'],
                      'patientBed':_referralProvider.referralData['patientBed'],
                      'patientComplaints':_referralProvider.referralData['patientComplaints'],
                      'patientDateAccident':_referralProvider.referralData['patientDateAccident'],
                      'patientTimeAccident':_referralProvider.referralData['patientTimeAccident'],
                      'fileUrlList':_referralProvider.referralData['fileUrlList'],
                    }).whenComplete(() {
                      _referralProvider.clearData();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AgentMainScreen();
                      },));
                    },);
                  }
                },
                child: Text('Create Referral'),
              ),
            ),
          ),
        ));
  }
}
