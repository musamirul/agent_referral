import 'package:agent_referral/views/screens/authentication_screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Your Account",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
              ),
              Text(
                'Explore the KPJ Klang Agent Exclusives',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.brown, fontSize: 14, letterSpacing: .2),
                ),
              ),
              Image.asset(
                'assets/images/kpjlogo.png',
                width: 250,
                height: 130,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, letterSpacing: .2),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  labelText: 'Enter your email',
                  labelStyle: GoogleFonts.getFont("Nunito Sans",
                      fontSize: 14, letterSpacing: 0.1),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600, letterSpacing: .2),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    labelText: 'Enter your password',
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility)),
              ),
              SizedBox(height: 30,),
              Stack(
                children: [
                  Container(width: 350,height: 40, decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(10)),child: Center(child: Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Need an Account? ',style: GoogleFonts.roboto(fontWeight: FontWeight.w500,letterSpacing: 1)), InkWell(onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    },));
                  },child: Text('Sign Up', style: GoogleFonts.roboto(color: Colors.orange,fontWeight: FontWeight.bold),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
