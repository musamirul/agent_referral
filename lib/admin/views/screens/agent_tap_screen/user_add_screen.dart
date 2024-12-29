import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:agent_referral/controller/user_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAddScreen extends StatefulWidget {
  const UserAddScreen({super.key});

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserController _userController = UserController();

  Future<Uint8List> loadImageAsBytes() async {
    return await rootBundle.load('assets/images/person_circle.png').then((data) => data.buffer.asUint8List());
  }

  late String fullName;
  late String email;
  late String username;
  late String password;
  late Uint8List? _image;

  void loadImage() async {
    _image = await loadImageAsBytes();
    setState(() {}); // Call this if _image is used in the UI.
  }

  String? _userOptionStatus;
  List<String> _userOption = ['Consultant', 'GP Clinic', 'KPJ Staff'];

  String? _deptOptionStatus;
  List<String> _deptOption = [
    'Diagnostic Imaging',
    'Physiotheraphy',
    'Spd',
  ];

  bool _passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    loadImage();
  }

  _saveUserDetail() async{
    EasyLoading.show(status: 'PLEASE WAIT');
    if(_formKey.currentState!.validate()){
      if (_userOptionStatus == null) {
        EasyLoading.showError('Please select a user type');
        return;
      }
      else if(_userOptionStatus=='Consultant'){
        await _userController
            .registerUser(fullName, email, _userOptionStatus!, password, _image)
            .whenComplete(
              () {
            EasyLoading.dismiss();

            setState(() {
              _formKey.currentState!.reset();
            });
          },
        );

        EasyLoading.dismiss();
      }else if(_userOptionStatus=='GP Clinic'){
        await _userController
            .registerGP(fullName, email, 'GP', password, _image)
            .whenComplete(
              () {
            EasyLoading.dismiss();

            setState(() {
              _formKey.currentState!.reset();
            });
          },
        );

        EasyLoading.dismiss();
      }
      else if(_userOptionStatus=='KPJ Staff') {
        await _userController
            .registerStaff(
            fullName, email, 'Staff', password, _deptOptionStatus!, _image)
            .whenComplete(
              () {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('User created successfully!');

            setState(() {
              _formKey.currentState!.reset();
            });
          },
        );

        EasyLoading.dismiss();
      }
    }else{
      print('Not updated');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(children: [
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
            child: Text(
              'Create User',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  letterSpacing: 0.5,
                  color: Colors.white),
            ),
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Full Name';
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
                    labelText: _userOptionStatus == "GP Clinic"
                        ? 'Enter Clinic Name'
                        : "Enter full name",
                    labelStyle: GoogleFonts.getFont("Nunito Sans",
                        fontSize: 14, letterSpacing: 0.1),
                    prefixIcon: _userOptionStatus == "GP Clinic"
                        ? Icon(Icons.local_hospital_rounded)
                        : Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter email address';
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
                    labelText: _userOptionStatus == "GP Clinic"
                        ? 'Enter Clinic Email'
                        : "Enter email",
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
                  obscureText: _passwordVisible,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter email address';
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
                      labelText: 'Enter password',
                      labelStyle: GoogleFonts.getFont("Nunito Sans",
                          fontSize: 14, letterSpacing: 0.1),
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: _passwordVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
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
                  items: _userOption.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userOptionStatus = value;
                    });
                  },
                ),
                if (_userOptionStatus == "KPJ Staff")
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelStyle: GoogleFonts.getFont("Nunito Sans",
                              fontSize: 14, letterSpacing: 0.1),
                          prefixIcon: Icon(Icons.support)),
                      hint: Text('Select Department'),
                      items: _deptOption
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _deptOptionStatus = value;
                        });
                      },
                    ),
                  ),
                SizedBox(
                  height: 8,
                ),
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        _saveUserDetail();
                      },
                      child: Container(
                        width: 350,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
