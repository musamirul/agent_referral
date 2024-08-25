import 'package:agent_referral/provider/referral_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class UploadReferralScreen extends StatefulWidget {
  @override
  _UploadReferralScreenState createState() => _UploadReferralScreenState();
}

class _UploadReferralScreenState extends State<UploadReferralScreen> with AutomaticKeepAliveClientMixin{
  List<File> selectedFiles = [];
  List<String> _files = [];
  bool _isLoading = false;
  final int _maxFileSize = 5 * 1024 * 1024; // 5MB

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Allow multiple files to be selected
      type: FileType.custom, // Restrict file types
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'], // Restrict to these file types
    );

    if (result != null) {
      List<File> validFiles = [];
      for (var file in result.files) {
        File selectedFile = File(file.path!);

        // Validate file size
        if (selectedFile.lengthSync() <= _maxFileSize) {
          validFiles.add(selectedFile);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${file.name} is too large. Please select a file under 5MB.'),
            ),
          );
        }
      }

      if (validFiles.isNotEmpty) {
        setState(() {
          selectedFiles.addAll(validFiles);
        });
      }
    }
  }

  Future<void> uploadFiles() async {
    final ReferralProvider _referralProvider = Provider.of<ReferralProvider>(context, listen: false);
    EasyLoading.show(status: 'Saving Document');
    try {
      for (var file in selectedFiles) {
        String fileName = file.path.split('/').last;
        Reference storageRef = FirebaseStorage.instance.ref().child('patientDocument/$fileName');

        UploadTask uploadTask = storageRef.putFile(file);

        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();
        _files.add(downloadUrl);
        print('Uploaded $fileName, Download URL: $downloadUrl');
      }

      setState(() {
        _referralProvider.getFormData(fileUrlList: _files);
        selectedFiles.clear();
        EasyLoading.dismiss();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Files uploaded successfully!'),
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload files: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Container(
        padding: EdgeInsets.only(left: 25,right: 25,),
        child: Column(
          children: [
            GradientIcon(
              icon: Icons.cloud_upload_rounded,
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              size: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,),
                onPressed: pickFile,
                icon: Icon(Icons.file_open,color: Colors.white),
                label: Text('Pick File(s)',style: TextStyle(color: Colors.white),),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: selectedFiles.length,
                  itemBuilder: (context, index) {
                    String fileName = selectedFiles[index].path.split('/').last;
                    return ListTile(
                      title: Text(fileName),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            selectedFiles.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$fileName removed.'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            if (selectedFiles.isNotEmpty) // Show upload button if files exist
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    Text('Please Click Upload Button First before Create Referral'),
                    ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50), backgroundColor: Colors.orange.shade500// Full-width button
                      ),
                      onPressed: uploadFiles,
                      icon: Icon(Icons.upload,color: Colors.white,),
                      label: Text('Upload Files',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}