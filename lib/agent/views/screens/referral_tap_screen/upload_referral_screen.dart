import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadReferralScreen extends StatefulWidget {
  const UploadReferralScreen({super.key});

  @override
  State<UploadReferralScreen> createState() => _UploadReferralScreenState();
}

class _UploadReferralScreenState extends State<UploadReferralScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<File> _file = [];
  List<String> _fileUrlList =[];

  chooseFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      _file.add(file);
    } else {
      // User canceled the picker
      print('no file picked');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(child: Text('click'),onPressed: () async{
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          File file = File(result.files.single.path!);
          _file.add(file);
        } else {
          // User canceled the picker
          print('no file picked');
        }
      },)),
    );
  }
}
