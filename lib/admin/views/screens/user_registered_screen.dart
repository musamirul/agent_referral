import 'package:agent_referral/admin/views/screens/user_tap_screen/user_list_screen.dart';
import 'package:agent_referral/admin/views/screens/user_tap_screen/user_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRegisteredScreen extends StatelessWidget {
  const UserRegisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(child: Text('User Management', style: GoogleFonts.roboto(letterSpacing: 0.9, fontWeight: FontWeight.w900,color: Colors.brown.shade900,fontSize: 26),)),
            ),
            backgroundColor: Colors.orange.shade400,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Register User'),
                ),
                Tab(
                  child: Text('User List'),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserRegisterScreen(),
              UserListScreen(),
            ],
          ),
        ));
  }
}
