import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 25, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to KPJ Klang'+ '\n'+'Referral System',
            style: GoogleFonts.roboto(fontWeight: FontWeight.w900,fontSize: 25,letterSpacing: 0.5),
          ),
          SizedBox(height: 10,),
          Text('Let us make your life easier and more comfortable with the smart ezy referral system',textAlign: TextAlign.left),
        ],
      ),
    );
  }
}