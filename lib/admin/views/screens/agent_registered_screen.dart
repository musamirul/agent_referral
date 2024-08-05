import 'package:flutter/material.dart';

import 'agent_tap_screen/agent_active_screen.dart';
import 'agent_tap_screen/agent_pending_screen.dart';

class AgentRegisteredScreen extends StatelessWidget {
  const AgentRegisteredScreen({super.key});

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
              Tab(child: Text('Pending'),),
              Tab(child: Text('Active'),),
            ],
          ),
        ),
        body: TabBarView(children: [
          AgentPendingScreen(),
          AgentActiveScreen(),
        ]),
      ),
    );
  }
}
