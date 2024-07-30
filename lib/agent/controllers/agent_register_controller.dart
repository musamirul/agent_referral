import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AgentController{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //FUNCTION TO STORE IMAGE IN FIREBASE STORAGE
  _uploadAgentImageToStorage(Uint8List? image) async{
    Reference ref = _storage.ref().child('storeImages').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //FUNCTION TO PICK STORE IMAGE
  pickStoreImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }else{
      print('No Image Selected');
    }
  }

  //FUNCTION TO SAVE AGENT DATA
  Future<String> registerAgent(
      String fullName,
      String email,
      String phoneNumber,
      String icNumber,
      String agentNumber,
      String agentOption,
      String insuranceOption,
      Uint8List? image,
      ) async
  {
    String res = 'some error occured';
    String storeImage = await _uploadAgentImageToStorage(image);
    //SAVE DATA TO CLOUD FIRESTORE
    await _firestore.collection('agents').doc(_auth.currentUser!.uid).set({
      'fullName':fullName,
      'email':email,
      'phoneNumber':phoneNumber,
      'icNumber':icNumber,
      'agentNumber':agentNumber,
      'agentOption': agentOption,
      'insuranceOption':insuranceOption,
      'image':storeImage,
      'approved':false,
      'agentId': _auth.currentUser!.uid,
    });
    return res;
  }

}