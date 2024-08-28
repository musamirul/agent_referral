import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Column(
                children: [
                  Icon(Icons.lock_open,color: Colors.white,),
                  Text('LOGOUT',style: GoogleFonts.lato(color: Colors.white,fontSize: 10)),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.transparent, // Make the AppBar background transparent
          elevation: 0, // Remove shadow
          flexibleSpace: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/header.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay (optional)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.7),
                        Colors.orange.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Centered title
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5), // Adjust as needed
                  child: Text(
                    'About',textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: 0.5, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_sync_rounded,size: 150,color: Colors.orange),
                    Icon(Icons.phone_android_rounded,size: 100,color: Colors.orange.shade800),
                  ],
                ),
                Text('About Ezzy Referral System',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Ezzy Referral is an innovative digital platform developed to enhance the referral process within KPJ Klang Specialist Hospital, streamlining communication and coordination among healthcare providers.'),
                SizedBox(height: 10,),
                Text('The platform primary goal is to improve patient care by ensuring timely, accurate, and well-coordinated referrals, which are crucial for delivering the right treatment at the right time. Ezzy Referral reduces administrative burdens, minimize delays, and enhances the overal patient experience'),
                SizedBox(height: 5,),
                Text('Objective',style: GoogleFonts.lato(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Main objectives are focused on improving the efficiency, accuracy, and overall quality of the referral process within the KPJ Klang Specialist Hospital system'),
                SizedBox(height: 20,),
                Image(image: AssetImage('assets/images/systemflow.jpg')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
