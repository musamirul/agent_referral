import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserController{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //FUNCTION TO STORE IMAGE IN FIREBASE STORAGE
  _uploadUserImageToStorage(Uint8List? image,String userId) async{
    Reference ref = _storage.ref().child('storeImages').child(userId);
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
      String insuranceOption,
      String userType,
      String password,
      Uint8List? image,
      ) async
  {
    String res = 'some error occured';

    //Create the new user
    UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    //SAVE IMAGE TO STORAGE
    String storeImage = await _uploadUserImageToStorage(image, cred.user!.uid);
    //SAVE DATA TO CLOUD FIRESTORE
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'fullName':fullName,
      'email':email,
      'phoneNumber':phoneNumber,
      'icNumber':icNumber,
      'agentNumber':agentNumber,
      'insuranceOption':insuranceOption,
      'image':storeImage,
      'approved':false,
      'userType' : userType,
      'userId': cred.user!.uid,
    });
    return res;
  }

  Future<String> registerUser(
      String fullName,
      String email,
      String userType,
      String password,
      Uint8List? image,
      ) async
  {
    String res = 'some error occured';

    //Create the new user
    UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    //SAVE IMAGE TO STORAGE
    String storeImage = await _uploadUserImageToStorage(image, cred.user!.uid);
    //SAVE DATA TO CLOUD FIRESTORE
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'fullName':fullName,
      'email':email,
      'image':storeImage,
      'approved':false,
      'userType':userType,
      'userId': cred.user!.uid,
    });
    return res;
  }

}