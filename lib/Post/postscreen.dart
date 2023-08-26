import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Authentication/Sign_in.dart';
import 'package:firebase_project/Post/Addpost.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class postscreen extends StatefulWidget {
  const postscreen({super.key});

  @override
  State<postscreen> createState() => _postscreenState();
}

class _postscreenState extends State<postscreen> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("post screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth
                    .signOut()
                    .then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignIn())))
                    .onError((error, stackTrace) {
                  Utils().toastmessage(error.toString());
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const addpost()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
