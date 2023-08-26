import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Authentication/Sign_in.dart';
import 'package:firebase_project/Firestore/Upload_image.dart';

import 'package:flutter/material.dart';

class Splashservices {
  void login(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
 Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Upload())));
    }
    else{
       Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn())));
    }

   
  }
}
