import 'package:agent_referral/admin/controller/admin_user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final UserController _userController = UserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String password;
  bool _isLoading = false;

  _signUpUser() async{
    setState(() {
      _isLoading = true;
    });
    if(_formKey.currentState!.validate()){
      await _userController.signUpUser(email, fullName, password).whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      },);
    }else{
      setState(() {
        _isLoading = false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Create User Account',style: TextStyle(fontSize: 20),),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Email address';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Full Name';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter Full Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Enter Password';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(labelText: 'Enter Password'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _signUpUser();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width -40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: _isLoading? CircularProgressIndicator(color: Colors.white,):Text('Register')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
