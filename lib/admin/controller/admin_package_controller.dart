import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PackageController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //FUNCTION TO STORE IMAGE IN FIREBASE STORAGE
  _uploadPackageImageToStorage(Uint8List? image, packageId) async {
    Reference ref = _storage.ref().child('packageImages').child(packageId);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //FUNCTION TO PICK STORE IMAGE
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  //FUNCTION TO SAVE PACKAGE DATA
  Future<String> createPackage(
    String title,
    String description,
    Uint8List? image,
    String packageId,
  ) async {
    String res = 'some error occured';
    String storeImage = await _uploadPackageImageToStorage(image, packageId);
    await _firestore.collection('package').doc(packageId).set({
      'description': description,
      'image': storeImage,
      'name': title,
      'packageId': packageId,
    });
    return res;
  }
}
