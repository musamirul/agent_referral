import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class ReasonScreen extends StatefulWidget {
  const ReasonScreen({super.key});

  @override
  State<ReasonScreen> createState() => _ReasonScreenState();
}

class _ReasonScreenState extends State<ReasonScreen> {
  List<DateTime?> _date = [DateTime.now().add(const Duration(days: 1))];
  List<DateTime?>? newDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {},
              decoration: InputDecoration(label: Text('Complaints / History')),
            ),
            Row(
              children: [
                Text('Date of Accident / Injury : '),
                TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.date,
                  initTime: DateTime.now(),
                  onChange: (p0) {

                  }
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Time of Accident / Injury : '),
                TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.time,
                  initTime: DateTime.now(),
                  onChange: (p0) {

                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
