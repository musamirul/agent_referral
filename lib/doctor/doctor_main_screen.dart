import 'package:agent_referral/doctor/views/screens/doctor_account_screen.dart';
import 'package:agent_referral/doctor/views/screens/doctor_dashboard_screen.dart';
import 'package:agent_referral/doctor/views/screens/doctor_referral_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({super.key});

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  int _pageIndex = 0;
  List<Widget> _pages =[
    DoctorDashboardScreen(),
    DoctorReferralScreen(),
    DoctorAccountScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.join_left),label: 'Referral'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Account'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
