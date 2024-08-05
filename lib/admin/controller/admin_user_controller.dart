import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController{
  Future<String> signUpUser(String email, String fullName, String password) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && fullName.isNotEmpty && password.isNotEmpty) {
        // Save the current admin user
        User? currentUser = FirebaseAuth.instance.currentUser;
        String? adminEmail = currentUser?.email;
        String? adminPassword;

        // Prompt admin for password (or retrieve it securely from storage)
         adminPassword = await getAdminPassword();

        if (adminEmail == null || adminPassword == null) {
          return "Admin email or password is missing";
        }

        // Create the new user
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        // Store the new user's data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'userId': cred.user!.uid,
          'userType': 'Doctor',
        });

        // Sign out the new user
        await FirebaseAuth.instance.signOut();

        // Re-authenticate the admin user
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: adminEmail, password: adminPassword);

        res = 'success';
      } else {
        res = 'All fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // This method should securely retrieve the admin's password.
  // Replace this with your actual implementation.
  Future<String> getAdminPassword() async {
    // Retrieve the admin's password securely
    return "bbkit@dmin";
  }
}