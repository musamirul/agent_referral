import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWelcomeWidget extends StatelessWidget {
  const HeaderWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to KPJ Klang'+ '\n'+'Referral System',textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: 0.5, color: Colors.white),
              ),
              SizedBox(height: 5,),
              Text('Let us make your life easier and more comfortable with the smart ezy referral system',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
