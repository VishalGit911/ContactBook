import 'dart:convert';
import 'package:contact_book/Screen/home/home_screen.dart';
import 'package:contact_book/Screen/signup/signup_screen.dart';
import 'package:contact_book/coman/snackbar.dart';
import 'package:contact_book/key_variable/key_variable.dart';
import 'package:contact_book/services/shared_preference.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final passwordconroller = TextEditingController();
  final gmailconroller = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String gmail = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Welcome back!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: gmailconroller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Gmail",
                            errorText: gmail,
                            suffixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: passwordconroller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Password",
                            errorText: password,
                            suffixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(350, 50),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              signinfunction();
                            }
                          },
                          child: Text("SignIn")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signinfunction() {
    String data = SharedPreferenceServices.getString(key: keyname.userkey);

    List userdata = [];

    if (data != "") {
      userdata = jsonDecode(data);

      bool match = userdata.any(
        (element) => element[keyname.gmail == gmailconroller.text.toString() &&
            element[keyname.password == passwordconroller.text.toString()]],
      );
      if (match) {
        snackbarcomman(context, "SignIn successfully");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        password = "password not valid";
        gmail = "Email not valid";
        snackbarcomman(context, "Email & Password not valid");
      }
    } else {
      password = "please enter passsword";
      gmail = "please enter email";
    }
  }
}
