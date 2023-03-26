import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/resources/storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return model.User.fromSnap(snap);
  }

  //signup the user

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file}) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty /*||
          file !=null*/
          ) {
//register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

//add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
      // } on FirebaseAuthException catch (error) {
      //   if (error.code == 'invalid-email') {
      //     res = 'Email is badly formatted';
      //   } else if (error.code == 'weak-password') {
      //     res = 'Password should be at least 6 character';
      //   }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        //here the sign must be && not ||
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please add all blanks";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
