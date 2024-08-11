import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackDetailScreen extends StatelessWidget {
  FeedbackDetailScreen({super.key,required this.feedbackId});
  String feedbackId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Feedback Detail')),);
  }
}
