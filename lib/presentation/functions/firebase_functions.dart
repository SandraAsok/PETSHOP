// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_catch_error

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petshop/main.dart';
import 'package:petshop/presentation/widgets/custom_bottonNav.dart';
import 'package:petshop/utilities/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SIGN-UP WITH EMAIL AND PASSWORD
Future signup(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('email', true);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => const MainNavigationScreen(),
            fullscreenDialog: true));
    return showDialog(
        context: context,
        builder: (context) =>
            SuccessAlert(mssg: "Account created successfully"));
  } catch (e) {
    log(e.toString());
    return showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: e.toString()));
  }
}

// SIGN-IN WITH EMAIL AND PASSWORD
Future signin(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('email', true);
    showDialog(
        context: context,
        builder: (context) =>
            SuccessAlert(mssg: "Account Logged-In successfully"));
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => const MainNavigationScreen(),
            fullscreenDialog: true));
  } catch (e) {
    log(e.toString());

    return showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: e.toString()));
  }
}

// SIGN-UP / SIGN-IN WITH GOOGLE
Future googleSignin(BuildContext context) async {
  try {
    final googlesiginin = GoogleSignIn();
    final googleUser = await googlesiginin.signIn().catchError((onError) {});
    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('email', true);
    showDialog(
        context: context,
        builder: (context) =>
            const SuccessAlert(mssg: "Account Logged-In successfully"));
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => const MainNavigationScreen(),
            fullscreenDialog: true));
  } catch (e) {
    log(e.toString());

    return showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: e.toString()));
  }
}

// SIGN-OUT WITH EMAIL AND PASSWORD
Future signout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('email', false);
    showDialog(
        context: context,
        builder: (context) =>
            SuccessAlert(mssg: "Account Logged-Out successfully"));
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => const Splash(), fullscreenDialog: true));
  } catch (e) {
    log(e.toString());
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert !"),
        content: Text(e.toString()),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }
}

// FORGOT PASSWORD / RESET PASSWORD
Future<void> resetPassword(BuildContext context, String email) async {
  if (email.isEmpty) {
    showDialog(
        context: context,
        builder: (context) => AttentionAlert(mssg: "Please enter your email"));
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showDialog(
        context: context,
        builder: (context) =>
            SuccessAlert(mssg: "Password reset link sent to $email"));
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'invalid-email') {
      message = 'Invalid email address.';
    } else {
      message = 'Something went wrong. Try again.';
    }
    showDialog(
        context: context, builder: (context) => AttentionAlert(mssg: message));
  }
}
