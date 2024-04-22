import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //signin
  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print("Id:${cred.user!.uid}");

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "The email is badly formated";
      } else if (err.code == "weak-password") {
        res = "password should be at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "user not found";
      } else if (e.code == "wrong-password") {
        res = "please enter correct password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
