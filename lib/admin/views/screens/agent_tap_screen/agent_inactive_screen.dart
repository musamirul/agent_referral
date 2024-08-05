import 'package:agent_referral/admin/views/screens/agent_tap_screen/agent_active_screen.dart';
import 'package:agent_referral/admin/views/screens/agent_tap_screen/agent_pending_screen.dart';
import 'package:flutter/material.dart';

class AgentInactiveScreen extends StatelessWidget {
  const AgentInactiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Pending'),),
              Tab(child: Text('Inactive'),),
              Tab(child: Text('Active'),),
            ],
          ),
        ),
        body: TabBarView(children: [
          AgentPendingScreen(),
          AgentInactiveScreen(),
          AgentActiveScreen(),
        ]),
      ),
    );
  }
}
