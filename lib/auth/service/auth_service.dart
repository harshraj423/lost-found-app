import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // auth instamce

// SignUp
  Future<String> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return "Please fill all the fields";
      }
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Store Created User in Firestore
      await _firestore.collection("users").doc(cred.user!.uid).set({
        "name": name,
        "email": email,
        "uid": cred.user!.uid,
        "createdAt": FieldValue.serverTimestamp(),
      });
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  // Login
  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  // For logout
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
// Auth Provider, Yhis allow access to auth method from anywhere in the app
final authMethodProvider = Provider<AuthMethod>((ref) {
  return AuthMethod();
});
