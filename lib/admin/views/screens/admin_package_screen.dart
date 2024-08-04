import 'package:agent_referral/admin/views/screens/package_tap_screen/package_create_screen.dart';
import 'package:agent_referral/admin/views/screens/package_tap_screen/package_list_screen.dart';
import 'package:flutter/material.dart';

class AdminPackageScreen extends StatefulWidget {
  const AdminPackageScreen({super.key});

  @override
  State<AdminPackageScreen> createState() => _AdminPackageScreenState();
}

class _AdminPackageScreenState extends State<AdminPackageScreen> {
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
             Tab(child: Text('Create Package'),),
             Tab(child: Text('Package List'),),
           ],
         ),
       ),
        body: TabBarView(children: [
          PackageCreateScreen(),
          PackageListScreen()
        ]),
      ),
    );
  }
}
