import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/UiLayer/Screens/ChatScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../UiLayer/Screens/LoginScreen.dart';

class AuthProvider {
 
  static Future<bool> userSignUp(
      String emailAddress, String password, BuildContext context) async {
    try {
      print("TT");
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
    Fluttertoast.showToast(msg:"The password provided is too weak.",
            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
       Fluttertoast.showToast(msg:"The account already exists for that email.",
            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> userSignIn(
      String emailAddress, String password, BuildContext context) async {
    print("T!!");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print("T!");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg:"No user found for that email.",
            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      Fluttertoast.showToast(msg:"'Wrong password provided for that user.",
            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static userSignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
