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
        backgroundColor: Colors.grey.shade800,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange.shade500,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration),label: 'Ref List'),
          BottomNavigationBarItem(
            icon: Container(
              width: 40, // Diameter of the circle
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.shade500, // Circle color
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30, // Icon size
                ),
              ),
            ),
            label: 'Create Refs',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline),label: 'KPJ Info'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback_outlined),label: 'Feedback'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),

        ],
      ),
      body: _pages[_pageIndex],
      );
  }
}
