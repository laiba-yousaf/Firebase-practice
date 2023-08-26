import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

import '../Widgets/roundbutton.dart';

class firestoreAdd extends StatefulWidget {
  const firestoreAdd({super.key});

  @override
  State<firestoreAdd> createState() => _firestoreAddState();
}

class _firestoreAddState extends State<firestoreAdd> {
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection("Users");

  final addcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Firestore"),
        ),
        body: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 4,
              controller: addcontroller,
              decoration: const InputDecoration(
                  hintText: "What is your mind", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          RoundButton(
              title: "ADD",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                String Id = DateTime.now().millisecondsSinceEpoch.toString();

                fireStore.doc(Id).set({
                  "title": addcontroller.text.toString(),
                  "id": Id
                }).then((value) {
                  Utils().toastmessage("Post added");
                     setState(() {
                loading = false;
              });
                }).onError((error, stackTrace) {
                  Utils().toastmessage(error.toString());
                       setState(() {
                loading = false;
              });
                });
              })
        ]));
  }
}
