import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to KPJ Klang'+ '\n'+'Referral System',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: 0.5, color: Colors.orange.shade900),
                ),
                SizedBox(height: 5,),
                Text('Let us make your life easier and more comfortable with the smart ezy referral system',textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 12),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}