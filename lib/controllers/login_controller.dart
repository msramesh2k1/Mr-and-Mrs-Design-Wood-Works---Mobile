import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_and_mrs/models/user_model.dart';

class LoginController extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  UserModel setusermodel(User user) {
    if (user != null) {
      print(user);
      setData(user);
      return UserModel(uid: user.uid, email: user.email);
    } else {
      print("something is wrong");
      return null;
    }
    // UserModel _usermodel = UserModel(uid:user.uid ,email: user.email);
    // return user != null  UserModel(uid: user.uid, email: user.email) : null;
  }

  void setData(User user) {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "phonenumber": user.phoneNumber,
      "profile_picture": user.photoURL,
      "name": user.displayName,
    });
  }


  Stream<UserModel> get user {
    return _auth.authStateChanges().map((User user) => setusermodel(user));
  }

  Future signIn({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User user = result.user;
      return setusermodel(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future signUp({String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User user = result.user;
      print(user);

      setusermodel(user);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  
  Future signout() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
