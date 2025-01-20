import 'package:agent_referral/agent/views/agent_main_screen.dart';
import 'package:agent_referral/agent/views/screens/patient_tap_screen/patient_pending_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/insurance_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/patient_family_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/reasons_screen.dart';
import 'package:agent_referral/agent/views/screens/referral_tap_screen/upload_referral_screen.dart';
import 'package:agent_referral/provider/referral_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PatientRegisterScreen extends StatefulWidget {
  PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      // Update the state when the tab index changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  'Create Referral',
                  style: GoogleFonts.roboto(
                    letterSpacing: 0.9,
                    fontWeight: FontWeight.w900,
                    color: Colors.brown.shade900,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.orange.shade400,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Patient',
                    style: GoogleFonts.oswald(
                      color: Colors.brown.shade600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Ins',
                    style: GoogleFonts.oswald(
                      color: Colors.brown.shade600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Reason',
                    style: GoogleFonts.oswald(
                      color: Colors.brown.shade600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Upload',
                    style: GoogleFonts.oswald(
                      color: Colors.brown.shade600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              PatientFamilyScreen(),
              InsuranceScreen(),
              ReasonScreen(),
              UploadReferralScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, fixedSize: Size(300, 30)),
              onPressed: () async{
                if (_tabController.index < _tabController.length - 1) {
                  // Go to the next tab
                  _tabController.animateTo(_tabController.index + 1);
                } else {
                  // Submit the form
                  if (_formKey.currentState!.validate()) {
                    final referralId = Uuid().v4();

                    await _firestore.collection('referral').doc(referralId).set(
                        {
                          'agentId' : _auth.currentUser!.uid,
                          'referralId' :referralId,
                          'status':'Pending',
                          'patientName':_referralProvider.referralData['patientName'],
                          'patientIc':_referralProvider.referralData['patientIc'],
                          'patientNationality':_referralProvider.referralData['patientNationality'],
                          'patientAddress':_referralProvider.referralData['patientAddress'],
                          'patientPhone':_referralProvider.referralData['patientPhone'],
                          'patientAge':_referralProvider.referralData['patientAge'],
                          'patientGender':_referralProvider.referralData['patientGender'],
                          'patientPayment':_referralProvider.referralData['patientPayment'],
                          'patientIns':_referralProvider.referralData['patientIns'],
                          'patientInsNumber':_referralProvider.referralData['patientInsNumber'],
                          'patientPolicyPeriod':_referralProvider.referralData['patientPolicyPeriod'],
                          'patientBed':_referralProvider.referralData['patientBed'],
                          'patientComplaints':_referralProvider.referralData['patientComplaints'],
                          'patientDateAccident':_referralProvider.referralData['patientDateAccident'],
                          'patientTimeAccident':_referralProvider.referralData['patientTimeAccident'],
                          'driverType':_referralProvider.referralData['driverType'],
                          'licence':_referralProvider.referralData['licence'],
                          'transportation':_referralProvider.referralData['transportation'],
                          'reasonReferral':_referralProvider.referralData['reasonReferral'],
                          'requestTreatment':_referralProvider.referralData['requestTreatment'],
                          'requestSpeciality':_referralProvider.referralData['requestSpeciality'],
                          'registeredDate':DateTime.now(),
                          'doctorAttending' :'empty',
                          'fileUrlList':_referralProvider.referralData['fileUrlList'],
                        });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Referral submitted successfully!')),
                    );
                    _referralProvider.clearData();
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PatientPendingScreen();
                    },));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Fill Up Missing Fields!')),
                    );
                  }
                }
              },
              label: Text(
                _tabController.index == _tabController.length - 1
                    ? 'SUBMIT'
                    : 'Next', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}