import 'package:agent_referral/staff/views/staff_account_screen.dart';
import 'package:agent_referral/staff/views/staff_dashboard_screen.dart';
import 'package:agent_referral/staff/views/staff_referral_screen.dart';
import 'package:flutter/material.dart';

class StaffMainScreen extends StatefulWidget {
  const StaffMainScreen({super.key});

  @override
  State<StaffMainScreen> createState() => _StaffMainScreenState();
}

class _StaffMainScreenState extends State<StaffMainScreen> {
  int _pageIndex =0;
  List<Widget> _pages = [
    StaffDashboardScreen(),
    StaffReferralScreen(),
    StaffAccountScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.join_left),label: 'Referral'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Account'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
