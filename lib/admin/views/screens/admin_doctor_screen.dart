import 'package:agent_referral/admin/views/screens/doctor_tap_screen/doctor_create_screen.dart';
import 'package:agent_referral/admin/views/screens/doctor_tap_screen/doctor_list_screen.dart';
import 'package:flutter/material.dart';

class AdminDoctorScreen extends StatelessWidget {
  const AdminDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        bottom: TabBar(
          tabs: [
            Tab(child: Text('Create Doctor'),),
            Tab(child: Text('Doctor List'),)
          ],
        ),
      ),
        body: TabBarView(children: [
          DoctorCreateScreen(),
          DoctorListScreen(),
        ]),
      ),
    );
  }
}
