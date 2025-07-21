import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/core/utils/app_shared_pref.dart';
import 'package:tasky_app/data/firebase/firebase_database.dart';
import 'package:tasky_app/models/user_model.dart';

class FirebaseAuthication {
  static final firebaseAuthAuth = FirebaseAuth.instance;

  static Future<void> login(String email, String password) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      final credential = await firebaseAuthAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.email == email) {
        print("email true ----------------------${credential.user!.email}");
      }
      print("credinal -------------------- ");
      AppSharedPref.saveData("Id", credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw Exception("Email or password is incorrect");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  static Future<void> register(
    String userName,
    String email,
    String password,
  ) async {
    try {
      final credential = await firebaseAuthAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseDatabase.createUser(
        UserModel(
          id: credential.user?.uid ?? "1",
          userName: userName,
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email.");
      }
    } catch (e) {
      throw Exception("Error is ${e.toString()}");
    }
  }
}
