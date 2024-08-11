import 'package:agent_referral/provider/referral_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen>
    with AutomaticKeepAliveClientMixin {
  List<String> _payOption = ['YES', 'NO'];
  List<String> _insuranceOption = [
    'AIA',
    'PRUDENTIAL',
    'GREAT EASTERN',
    'PM CARE',
    'CUEPACS',
    'OTHERS'
  ];
  List<String> _bedOption = [
    'None',
    'Single',
    'Double',
    'Premier',
    'HDU',
    'Other'
  ];
  String? bed;
  String? selfPay;
  String? insuranceType;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ReferralProvider _referralProvider =
        Provider.of<ReferralProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                hint: Text('Self Pay?'),
                items: _payOption.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selfPay = value;
                    _referralProvider.getFormData(patientPayment: value);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (selfPay == 'NO')
                Column(
                  children: [
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelStyle: GoogleFonts.getFont("Nunito Sans",
                            fontSize: 14, letterSpacing: 0.1),
                      ),
                      hint: Text('Select Insurance Type'),
                      items: _insuranceOption
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        insuranceType = value;
                        _referralProvider.getFormData(patientIns: value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _referralProvider.getFormData(patientInsNumber: value);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Insurance Policy Number',
                        labelStyle: GoogleFonts.getFont("Nunito Sans",
                            fontSize: 14, letterSpacing: 0.1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _referralProvider.getFormData(
                            patientPolicyPeriod: value);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Policy Period',
                        labelStyle: GoogleFonts.getFont("Nunito Sans",
                            fontSize: 14, letterSpacing: 0.1),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Text(
                  style: TextStyle(fontSize: 12, color: Colors.red),
                  '**For self-transport, bed is reserved up to 4 hours after referral is accepted by the specialist.'),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                ),
                hint: Text('Requested Bed'),
                items: _bedOption.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    bed = value;
                    _referralProvider.getFormData(patientBed: value);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
