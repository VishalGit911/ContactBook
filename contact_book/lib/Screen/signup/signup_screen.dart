import 'dart:convert';

import 'package:contact_book/Screen/home/home_screen.dart';
import 'package:contact_book/Screen/signin/signin_screen.dart';
import 'package:contact_book/key_variable/key_variable.dart';
import 'package:contact_book/services/shared_preference.dart';
import 'package:flutter/material.dart';

import '../../coman/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fnameconroller = TextEditingController();
  final lnameconroller = TextEditingController();
  final contackconroller = TextEditingController();
  final passwordconroller = TextEditingController();
  final gmailconroller = TextEditingController();

  String? fname;
  String? lname;
  String? contact;
  String? password;
  String? gmail;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Welcome",
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
                          "Create Your Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: fnameconroller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "First Name",
                                    errorText: fname,
                                    suffixIcon: Icon(Icons.edit),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: lnameconroller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Last Name Name",
                                    errorText: lname,
                                    suffixIcon: Icon(Icons.edit),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ),
                        ],
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
                          controller: contackconroller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Contact N0",
                              errorText: contact,
                              suffixIcon: Icon(Icons.call),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "already have account ?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninScreen(),
                                    ));
                              },
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(350, 50),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black),
                            onPressed: () {
                              print("object");
                              if (globalKey.currentState!.validate()) {
                                fname = "Please enter First Name";
                                lname = "Please enter Last Name";
                                gmail = "Please enter Gmail";
                                contact = "Please enter contact";
                                password = "Please enter password";
                              } else {
                                signupfunction();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              }
                            },
                            child: Text("SignUp")),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signupfunction() async {
    String data = SharedPreferenceServices.getString(key: keyname.userkey);

    List useregister = [];

    if (data != "") {
      useregister = jsonDecode(data);
      useregister.add({
        keyname.fname: fnameconroller.text.toString(),
        keyname.lname: lnameconroller.text.toString(),
        keyname.gmail: gmailconroller.text.toString(),
        keyname.contact: contackconroller.text.toString(),
        keyname.password: passwordconroller.text.toString(),
      });
    }

    String newdata = jsonEncode(useregister);

    SharedPreferenceServices.setdata(key: keyname.userkey, value: newdata);

    snackbarcomman(context, "Data register successfully");
  }
}
