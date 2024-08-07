import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgentPendingScreen extends StatefulWidget {
  const AgentPendingScreen({super.key});

  @override
  State<AgentPendingScreen> createState() => _AgentPendingScreenState();
}

class _AgentPendingScreenState extends State<AgentPendingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _agentStream =
      FirebaseFirestore.instance.collection('users').where('approved',isEqualTo: false).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _agentStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return snapshot.data!.docs.length == 0 ? Center(child: Text('No pending users for approval'),):ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final agentData = snapshot.data!.docs[index];
            return ListTile(
              title: Text(agentData['fullName']),
              subtitle: Text(agentData['email']),
              trailing: agentData['approved']==false ? ElevatedButton(onPressed: () async{
                await _firestore.collection('users').doc(agentData['userId']).update({'approved': true});
              }, child: Text('Approved')): ElevatedButton(onPressed: () async{
                await _firestore.collection('users').doc(agentData['userId']).update({'approved':false});
              }, child: Text('Reject')),
            );
          },
        );
      },
    );
  }
}
