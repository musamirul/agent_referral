import 'dart:typed_data';

import 'package:agent_referral/agent/controllers/agent_register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AgentRegistrationScreen extends StatefulWidget {
  const AgentRegistrationScreen({super.key});

  @override
  State<AgentRegistrationScreen> createState() =>
      _AgentRegistrationScreenState();
}

class _AgentRegistrationScreenState extends State<AgentRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AgentController _agentController = AgentController();

  late String fullName;
  late String email;
  late String phoneNumber;
  late String icNumber;
  late String agentNumber;
  Uint8List? _image;

  String? _agentOptionStatus;
  List<String> _agentOption = ['YES', 'NO'];
  String? _insuranceOptionStatus;
  List<String> _insuranceOption = [
    'AIA',
    'ETIQA',
    'ALLIANZ',
    'ZURICH',
    'TAKAFUL',
    'GREAT EASTERN'
  ];

  selectCameraImage() async {
    Uint8List im = await _agentController.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  _saveAgentDetail() async {
    EasyLoading.show(status: 'PLEASE WAIT');
    if (_formKey.currentState!.validate()) {
      await _agentController
          .registerAgent(fullName, email, phoneNumber, icNumber, agentNumber,
              _agentOptionStatus!, _insuranceOptionStatus!, _image)
          .whenComplete(
        () {
          EasyLoading.dismiss();

          setState(() {
            _formKey.currentState!.reset();
            _image = null;
          });
        },
      );
    } else {
      print('Not updated');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.red.shade500,
                      Colors.blue.shade300
                    ])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                          labelText: 'Full Name', border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
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
                          labelText: 'Email Address',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Phone Number';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        icNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter IC Number';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'IC Number', border: OutlineInputBorder()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Agent Registered?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: 100,
                              child: DropdownButtonFormField(
                                hint: Text('Select'),
                                items:
                                    _agentOption.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem(
                                        value: value, child: Text(value));
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _agentOptionStatus = value;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_agentOptionStatus == 'YES')
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              child: DropdownButtonFormField(
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
                            TextFormField(
                              onChanged: (value) {
                                agentNumber = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Agent Number'),
                            ),
                          ],
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        _saveAgentDetail();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
