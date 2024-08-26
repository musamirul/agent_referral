import 'package:agent_referral/agent/views/screens/account_screen.dart';
import 'package:agent_referral/agent/views/widgets/banner_widget.dart';
import 'package:agent_referral/agent/views/widgets/welcome_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data available');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('done');
        }
        // Extract the agentNumber from the document
        String agentNumber = snapshot.data!['agentNumber'] ?? 'No agent number';
        String agentName = snapshot.data!['fullName'] ?? 'No agent name';

        return Scaffold(
          backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.orange.shade300,
                    backgroundImage: NetworkImage(snapshot.data!['image']),
                  ),
                ),
              ],
              title: Text(
                'Hello! ' + agentName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.orange.shade300,
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // DrawerHeader(child: Text('Hi Admin')),
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.amber.shade500,
                        ),
                        currentAccountPicture: CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.orange.shade300,
                          backgroundImage:
                              NetworkImage(snapshot.data!['image']),
                        ),
                        accountName: Text(agentName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        accountEmail: Text(_auth.currentUser!.email.toString(),
                            style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: ListTile(
                            leading: Icon(
                              Icons.home,
                            ),
                            title: Text(
                              'Home',
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: ListTile(
                            leading: Icon(
                              Icons.info,
                            ),
                            title: Text('About')),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AccountScreen()));
                          },
                          child: ListTile(
                              leading: Icon(
                                Icons.settings,
                              ),
                              title: Text('Profile')),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 25),
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                      ),
                      title: Text('Logout'),
                      onTap: () async {
                        await _auth.signOut();
                      },
                    ),
                  )
                ],
              ),
            ),
            body:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    BannerWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: WelcomeText(),
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
