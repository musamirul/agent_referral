import 'package:agent_referral/provider/referral_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:intl/intl.dart';

class ReasonScreen extends StatefulWidget {
  const ReasonScreen({super.key});

  @override
  State<ReasonScreen> createState() => _ReasonScreenState();
}

class _ReasonScreenState extends State<ReasonScreen> with AutomaticKeepAliveClientMixin{
  // List<DateTime?> _date = [DateTime.now().add(const Duration(days: 1))];
  List<DateTime?>? newDate;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                _referralProvider.getFormData(patientComplaints: value);
              },
              decoration: InputDecoration(label: Text('Complaints / History')),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Date of Accident / Injury : '),
                TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.date,
                  initTime: DateTime.now(),
                  timeFormat: 'dd/MM/yyyy',
                  onChange: (dateTime) {
                    _referralProvider.getFormData(patientDateAccident: DateFormat('dd/MM/yyy').format(dateTime));
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
                  timeFormat: 'HH:mm:ss',
                  onChange: (dateTime) {
                    _referralProvider.getFormData(patientTimeAccident: DateFormat('HH:mm:ss').format(dateTime));
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
