import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_and_mrs/Helper.dart';
import 'package:mr_and_mrs/models/user_model.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  UserModel setusermodel(User user) {
    if (user != null) {
      print(user);

      return UserModel(uid: user.uid, email: user.email);
    } else {
      print("something is wrong");
      return null;
    }
    // UserModel _usermodel = UserModel(uid:user.uid ,email: user.email);
    // return user != null  UserModel(uid: user.uid, email: user.email) : null;
  }

  void setData(User user, String name) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({"uid": user.uid, "email": user.email, "name": name});
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((User user) => setusermodel(user));
  }

  Future signIn({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User user = result.user;
      MRANDMRS.sharedprefs.setString("uid", user.uid);

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      UserModel userdata = UserModel.fromSnapshot(snapshot.data());
      _userModel = userdata;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future signUp({String name, String email, String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      User user = result.user;
      MRANDMRS.sharedprefs.setString("uid", user.uid);
      MRANDMRS.sharedprefs.setString("email", user.email);
      print(user);

      setusermodel(user);

      setData(user, name);
      UserModel userdata =
          UserModel(email: user.email, uid: user.uid, name: name);
      _userModel = userdata;

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
