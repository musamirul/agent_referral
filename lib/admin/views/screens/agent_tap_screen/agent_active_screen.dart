import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgentActiveScreen extends StatefulWidget {
  const AgentActiveScreen({super.key});

  @override
  State<AgentActiveScreen> createState() => _AgentActiveScreenState();
}

class _AgentActiveScreenState extends State<AgentActiveScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _agentStream =
  FirebaseFirestore.instance.collection('users').where('approved',isEqualTo: true).snapshots();

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

        return ListView.builder(
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
