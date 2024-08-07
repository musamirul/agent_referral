import 'dart:typed_data';
import 'package:agent_referral/agent/controllers/agent_register_controller.dart';
import 'package:agent_referral/controller/user_register_controller.dart';

import 'package:agent_referral/views/screens/authentication_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserController _userController = UserController();

  late String fullName;
  late String email;
  late String phoneNumber;
  late String icNumber;
  late String agentNumber;
  late String password;
  Uint8List? _image;

  String? _insuranceOptionStatus;
  List<String> _insuranceOption = [
    'AIA',
    'ETIQA',
    'ALLIANZ',
    'ZURICH',
    'TAKAFUL',
    'GREAT EASTERN'
  ];

  String? _userOptionStatus;
  List<String> _userOption = [
    'Agent',
    'Consultant',
  ];

  selectCameraImage() async {
    Uint8List im = await _userController.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  _saveUserDetail() async {
    EasyLoading.show(status: 'PLEASE WAIT');
    if (_formKey.currentState!.validate()) {
      if(_userOptionStatus=='Agent'){
        await _userController
            .registerAgent(fullName, email, phoneNumber, icNumber, agentNumber,
            _insuranceOptionStatus!, _userOptionStatus!,password,_image)
            .whenComplete(
              () {
            EasyLoading.dismiss();

            setState(() {
              _formKey.currentState!.reset();
              _image = null;
            });
          },
        );

        EasyLoading.dismiss();

      }else if(_userOptionStatus=='Consultant'){
        await _userController
            .registerUser(fullName, email, _userOptionStatus!, password, _image)
            .whenComplete(
              () {
            EasyLoading.dismiss();

            setState(() {
              _formKey.currentState!.reset();
              _image = null;
            });
          },
        );

        EasyLoading.dismiss();
      }

    } else {
      print('Not updated');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Your Account",
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
                  // Image.asset(
                  //   'assets/images/kpjlogo.png',
                  //   width: 200,
                  //   height: 50,
                  // ),
                  SizedBox(height: 10,),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image != null
                        ? Image.memory(
                      _image!,
                      fit: BoxFit.cover,
                    )
                        : IconButton(
                      onPressed: () {
                        selectCameraImage();
                      },
                      icon: Icon(
                        Icons.account_box_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Full Name',
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, letterSpacing: .2),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Full Name';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your full name',
                      labelStyle: GoogleFonts.getFont("Nunito Sans",
                          fontSize: 14, letterSpacing: 0.1),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 15,),
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
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your email address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
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
                    height: 15,
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
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your email address';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
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
                  SizedBox(height: 15,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.red.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    hint: Text('Select Access Type'),
                    items:
                    _userOption.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _userOptionStatus = value;
                      });
                    },
                  ),

                  if(_userOptionStatus=="Agent")
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              icNumber = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              labelText: 'Enter IC/Passport number',
                              labelStyle: GoogleFonts.getFont("Nunito Sans",
                                  fontSize: 14, letterSpacing: 0.1),
                              prefixIcon: Icon(Icons.credit_card),
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              labelText: 'Enter phone number',
                              labelStyle: GoogleFonts.getFont("Nunito Sans",
                                  fontSize: 14, letterSpacing: 0.1),
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                labelStyle: GoogleFonts.getFont("Nunito Sans",
                                    fontSize: 14, letterSpacing: 0.1),
                                prefixIcon: Icon(Icons.support_agent),
                              ),
                              hint: Text('Select Insurance Type'),
                              items: _insuranceOption
                                  .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _insuranceOptionStatus = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(

                            onChanged: (value) {
                              agentNumber = value;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                labelText: 'Enter agent number',
                                labelStyle: GoogleFonts.getFont("Nunito Sans",
                                    fontSize: 14, letterSpacing: 0.1),
                                prefixIcon: Icon(Icons.numbers),
                            ),
                          ),

                        ],
                      ),
                    ),
                  SizedBox(height: 8,),
                  Stack(
                    children: [
                      InkWell(onTap: () {
                        _saveUserDetail();
                      },child: Container(width: 350,height: 40, decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(10)),child: Center(child: Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)))),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account? ',style: GoogleFonts.roboto(fontWeight: FontWeight.w500,letterSpacing: 1)), InkWell(onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        },));
                      },child: Text('Sign In', style: GoogleFonts.roboto(color: Colors.orange,fontWeight: FontWeight.bold),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
