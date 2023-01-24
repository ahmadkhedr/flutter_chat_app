// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../DataLayer/Auth/AuthProvider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController mailController = TextEditingController();
  TextEditingController passwoed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Container(
        color: Color(0xFF00BA8B),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: emailTextFiled(context)),
              SizedBox(
                height: 10.0,
              ),
              Center(child: passwoedTextFiled(context)),
              SizedBox(
                height: 50.0,
              ),
              SignInButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextFiled(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //  // borderRadius: BorderRadius.circular(25.0)
      // ),
      width: MediaQuery.of(context).size.width * .75,
      child: TextField(
          controller: mailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(width: 0.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            alignLabelWithHint: true,
            suffix: const Icon(
              Icons.mail,
              color: Colors.blue,
            ),
            hintText: 'youremail@gmail.com',
            //label: Text("Your Email Address"),
          )),
    );
  }

  Widget passwoedTextFiled(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      child: TextField(
          controller: passwoed,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,

            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(width: 0.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue),
            // ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            alignLabelWithHint: true,
            suffix: const Icon(
              Icons.password,
              color: Colors.blue,
            ),
            hintText: 'your Password',
            // label: Text("Your Password"),
          )),
    );
  }

  Widget SignInButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
        
      ),
      onPressed: () {
        AuthProvider.userSignUp(mailController.text, passwoed.text, context);
      },
      child: Text(
        "Sign Up",
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );
  }
}

