import 'package:agent_referral/admin/views/screens/admin_dashboard_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_doctor_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_feedback_screen.dart';
import 'package:agent_referral/admin/views/screens/admin_package_screen.dart';
import 'package:agent_referral/admin/views/screens/agent_registered_screen.dart';
import 'package:agent_referral/admin/views/screens/user_registered_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _pageIndex =0;
  List<Widget> _pages=[
    AdminDashboardScreen(),
    AdminPackageScreen(),
    AdminDoctorScreen(),
    AgentRegisteredScreen(),
    AdminFeedbackScreen(),
    // UserRegisteredScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.image),label: 'Package'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital),label: 'Doctor'),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.feed_rounded),label: 'Feedback'),
          // BottomNavigationBarItem(icon: Icon(Icons.add),label: 'User')
      ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
