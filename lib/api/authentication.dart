import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String displayName;
  String email;
  String uid;
  String password;

  UserData({this.displayName, this.email, this.uid, this.password});
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

var uid;
var error;
var loginerror = null;

final DocumentReference docRefUsers =
    Firestore.instance.collection("$uid").document('User Details');
String userName = '';
String userEmail = '';

fetchuserdata() async {
  await docRefUsers.get().then((datasnapshot) {
    if (datasnapshot.exists) {
      print('Fetching Data');
      userName = datasnapshot.data['Name'];
      userEmail = datasnapshot.data['Email'];
    }
  });
}

class UserAuth {
  String statusMsg = "We have sent an email to verify your email address.";

  //To create new User
  Future<String> createUser(UserData userData) async {
    FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: userData.email, password: userData.password)
        .catchError(error);
    print(error);
    await user.sendEmailVerification();
    return statusMsg;
  }

//  //To verify new User
  Future<String> verifyUser(UserData userData) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: userData.email, password: userData.password);
    bool userverified = user.isEmailVerified;
    uid = user.uid;
    print(userverified);
    if (userverified == false) {
      user.sendEmailVerification();
      return "Please Verify Your Email Address";
    }

    await fetchuserdata();
    return "Login Successfull";
  }

//  //To verify new User
//  Future<String> verifyUser(UserData userData) async {
//    FirebaseUser user =
//    await _firebaseAuth
//        .signInWithEmailAndPassword(
//        email: userData.email, password: userData.password).catchError(
//            (e) => loginerror = e);
//    print(loginerror);
//      bool userverified = user.isEmailVerified;
//      uid = user.uid;
//      if (userverified == false) {
//        print('Verifying user ');
//        user.sendEmailVerification();
//        loginerror=null;
//        return "Please Verify Your Email Address";
//      } else  if(loginerror == null){
//        print('Login success');
//        loginerror= null;
//        await fetchuserdata();
//      return "Login Successfull";
//
//      }
//    else
//      print('some error occured');
//      return "$loginerror";
//
//
//
//
//  }

  //To reset password
  Future<String> resetPassword(UserData userData) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.sendPasswordResetEmail(email: userData.email);
    return "Reset link has been sent to your email address.";
  }
}
