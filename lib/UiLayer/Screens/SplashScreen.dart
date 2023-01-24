// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/UiLayer/Screens/LoginScreen.dart';
import 'package:flutter_chat_app/UiLayer/Screens/SignUpScreen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF00BA8B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Chat App",
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              Icon(
                Icons.electric_bolt,
                color: Colors.yellow[300],
                size: 80.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              signUp(context),
              SizedBox(
                height: 20.0,
              ),
              SignIn(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
      child: Text(
        "Sighn Up",
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );
  }

  Widget SignIn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width / 2, 50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Text(
        "Sign In",
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );
  }
}
