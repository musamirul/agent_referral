import 'package:agent_referral/agent/views/screens/hospital_tap_screen/doctor_info_screen.dart';
import 'package:agent_referral/agent/views/screens/hospital_tap_screen/package_info_screen.dart';
import 'package:flutter/material.dart';

class HospitalInfoScreen extends StatefulWidget {
  const HospitalInfoScreen({super.key});

  @override
  State<HospitalInfoScreen> createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(child: Text('Package'),),
              Tab(child: Text('Doctor'),)
            ]),
          ),
          body: TabBarView(children: [
            PackageInfoScreen(),
            DoctorInfoScreen(),
          ]),
        ));
  }
}
