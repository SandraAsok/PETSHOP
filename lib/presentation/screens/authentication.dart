// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/presentation/functions/firebase_functions.dart';
import 'package:petshop/utilities/utility.dart';

class LoginScreen extends StatefulWidget {
  static String? verify;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAccount = false;
  bool _obscurePassword = true; // 👁️ password visibility toggle

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Email validation function
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20.0),
        child: Text(
          "Go ahead \n setup your account",
          style: GoogleFonts.caveatBrush(color: Colors.white, fontSize: 35),
        ),
      ),
      bottomSheet: BottomSheet(
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shadowColor: blueshade,
            child: Column(
              children: [
                height50,
                // Email field
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: textfieldBorderStyle,
                      enabledBorder: textfieldBorderStyle,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                // Password field with visibility toggle
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _password,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: textfieldBorderStyle,
                      enabledBorder: textfieldBorderStyle,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Forgot password
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      if (_email.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AttentionAlert(
                              mssg: "Please enter your email"),
                        );
                      } else if (!_isValidEmail(_email.text.trim())) {
                        showDialog(
                          context: context,
                          builder: (context) => const AttentionAlert(
                              mssg: "Please enter a valid email"),
                        );
                      } else {
                        resetPassword(context, _email.text.trim());
                      }
                    },
                    child: const Text("Forgot password ?"),
                  ),
                ),
                // Login / Create button
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      if (_email.text.isEmpty || _password.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AttentionAlert(
                              mssg: "Please enter both email and password"),
                        );
                      } else if (!_isValidEmail(_email.text.trim())) {
                        showDialog(
                          context: context,
                          builder: (context) => const AttentionAlert(
                              mssg: "Please enter a valid email"),
                        );
                      } else {
                        isAccount
                            ? signup(context, _email.text.trim(),
                                _password.text.trim())
                            : signin(context, _email.text.trim(),
                                _password.text.trim());
                      }
                    },
                    child: Text(
                      isAccount ? "Create" : "Login",
                      style: GoogleFonts.caveatBrush(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                height20,
                // Switch between login and create account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isAccount
                          ? "Already have an account ?"
                          : "Don't have an account ? ",
                      style: GoogleFonts.caveatBrush(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isAccount = !isAccount;
                        });
                      },
                      child: Text(
                        isAccount ? "Login" : "Create",
                        style: GoogleFonts.caveatBrush(
                          color: bgcolor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                height20,
                const Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Divider(color: Colors.black),
                ),
                height20,
                // Google sign-in button
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      if (_email.text.isEmpty || _password.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AttentionAlert(
                              mssg: "Please Enter Email/Password"),
                        );
                      } else if (!_isValidEmail(_email.text.trim())) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const AttentionAlert(mssg: "Not a valid Account"),
                        );
                      } else {
                        googleSignin(context);
                      }
                    },
                    child: Text(
                      "Continue with Google",
                      style: GoogleFonts.caveatBrush(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 8,
        onClosing: () {},
        enableDrag: false,
        shadowColor: purpleshade,
      ),
    );
  }
}
