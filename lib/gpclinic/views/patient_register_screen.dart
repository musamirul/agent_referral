import 'package:agent_referral/gpclinic/views/screens/referral_tap_screen/diagnostic_screen.dart';
import 'package:agent_referral/gpclinic/views/screens/referral_tap_screen/physio_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientRegisterScreen extends StatelessWidget {
  const PatientRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/header.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(0.7),
                    Colors.orange.withOpacity(0.6)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Referral',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                'Please Select Referral Type Below',
                style: GoogleFonts.lato(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiagnosticScreen(),));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                            left: 20,
                            right: 30,
                          ),
                          child: Icon(
                            Icons.compare,
                            size: 50,
                            color: Colors.orange.shade400,
                          ),
                        ),
                        Text(
                          'Diagnostic Imaging Services',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),


              InkWell(
                // onTap: () {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => PhysioScreen(),));
                // },
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                            left: 20,
                            right: 30,
                          ),
                          child: Icon(
                            Icons.settings_accessibility,
                            size: 50,
                            color: Colors.orange.shade400,
                          ),
                        ),
                        Text(
                          'Physiotherapy Services (unavailable)',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
