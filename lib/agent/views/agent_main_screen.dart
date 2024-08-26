import 'package:agent_referral/agent/views/screens/account_screen.dart';
import 'package:agent_referral/agent/views/screens/agent_home_screen.dart';
import 'package:agent_referral/agent/views/screens/feedback_screen.dart';
import 'package:agent_referral/agent/views/screens/hospital_info_screen.dart';
import 'package:agent_referral/agent/views/screens/patient_register_screen.dart';
import 'package:agent_referral/agent/views/screens/patient_registered_list_screen.dart';
import 'package:flutter/material.dart';

class AgentMainScreen extends StatefulWidget {
  const AgentMainScreen({super.key});

  @override
  State<AgentMainScreen> createState() => _AgentMainScreenState();
}

class _AgentMainScreenState extends State<AgentMainScreen> {
  int _pageIndex=0;
  List<Widget> _pages = [
    AgentHomeScreen(),
    PatientRegisteredListScreen(),
    PatientRegisterScreen(),
    HospitalInfoScreen(),
    FeedbackScreen(),
    // AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration),label: 'Ref List'),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Create Ref'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline),label: 'KPJ Info'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback),label: 'Feedback'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

        ],
      ),
      body: _pages[_pageIndex],
      );
  }
}
