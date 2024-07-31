import 'package:agent_referral/agent/views/screens/referral_tap_screen/insurance_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/patient_family_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/reasons_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/referring_person_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/upload_referral_screen.dart';
import 'package:flutter/material.dart';

class PatientRegisterScreen extends StatelessWidget {
  const PatientRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade500,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Referral'),
                ),
                Tab(
                  child: Text('Family'),
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
              onPressed: () {},
              child: Text('Create Referral'),
            ),
          ),
        ));
  }
}
