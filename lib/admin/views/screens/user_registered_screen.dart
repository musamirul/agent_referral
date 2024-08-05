import 'package:agent_referral/admin/views/screens/user_tap_screen/user_list_screen.dart';
import 'package:agent_referral/admin/views/screens/user_tap_screen/user_register_screen.dart';
import 'package:flutter/material.dart';

class UserRegisteredScreen extends StatelessWidget {
  const UserRegisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
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
