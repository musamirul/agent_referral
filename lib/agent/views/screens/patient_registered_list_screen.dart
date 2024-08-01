import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_history_screen.dart';
import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_pending_screen.dart';
import 'package:flutter/material.dart';

class PatientRegisteredListScreen extends StatelessWidget {
  const PatientRegisteredListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        elevation: 0,
        bottom: TabBar(tabs: [
          Tab(child: Text('Pending Approval'),),
          Tab(child: Text('History'),),
        ]),
      ),
      body: TabBarView(children: [
        PatientPendingScreen(),
        PatientHistoryScreen(),
      ]),
    ));
  }
}
