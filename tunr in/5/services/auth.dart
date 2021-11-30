
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../pages/home_page.dart';

class Auth {
  static final auth = FirebaseAuth.instance;


  static Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    }on FirebaseAuthException catch(e) {
      return _parseSignInAuthException(e);
    }
  }

  static Future<String> createAccountWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _parseCreateAccountAuthException(e);
    }
  }

  static Future<void> signOut() {
    return auth.signOut();
  }

  static Future<String> getUserId() async {
    // TODO
  }

  static Future<bool> isSignedIn() async {
    if(FirebaseAuth.instance.currentUser != null){
      return true;
    }
    else return false;
  }


  static String _parseSignInAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'ERROR_INVALID_EMAIL':
        return 'Email address is not formatted correctly';
      case 'ERROR_USER_NOT_FOUND':
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_DISABLED':
        return 'Invalid username or password';
      case 'ERROR_TOO_MANY_REQUESTS':
      case 'ERROR_OPERATION_NOT_ALLOWED':
      default:
        return 'An unknown error occurred';
    }
  }

  static String _parseCreateAccountAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'ERROR_WEAK_PASSWORD':
        return 'Password is too weak';
      case 'ERROR_INVALID_EMAIL':
        return 'Email address is not formatted correctly';
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'This email address is already in use';
      default:
        return 'An unknown error occurred';
    }
  }
}
