import 'dart:typed_data';

import 'package:agent_referral/admin/controller/admin_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PackageCreateScreen extends StatefulWidget {
  const PackageCreateScreen({super.key});

  @override
  State<PackageCreateScreen> createState() => _PackageCreateScreenState();
}

class _PackageCreateScreenState extends State<PackageCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PackageController _packageController = PackageController();

  late String title;
  late String description;
  Uint8List? _image;


  selectImage() async{
    Uint8List im = await _packageController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  _savePackageDetail() async{
    EasyLoading.show(status: 'PLEASE WAIT');
    String packageId = Uuid().v4();
    if(_formKey.currentState!.validate()){
      await _packageController.createPackage(title, description, _image, packageId).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      },);
    }else{
      print('Not updated');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: () {
          selectImage();
        },
        icon: Icon(Icons.browse_gallery),
        label: Text('Browse Gallery'));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Title Name';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(label: Text('Title')),
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [Colors.red.shade100,Colors.blue.shade200])
                ),
                height: 300,
                width: double.infinity,
                alignment: Alignment.center,
                child: _image != null ? Image.memory(_image!, fit: BoxFit.cover,):content,
              ),
              SizedBox(height: 16,),
              TextFormField(
                maxLength: 800,
                maxLines: 4,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),label: Text('Description')),
                onChanged: (value) {
                  description = value;
                },
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please Enter Package Description';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton.icon(onPressed: () {
                _savePackageDetail();
              }, icon: Icon(Icons.add), label: Text('Add Package'))

            ]),
          ),
        ),
      ),
    );
  }
}
