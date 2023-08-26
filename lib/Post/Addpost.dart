import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/Widgets/roundbutton.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class addpost extends StatefulWidget {
  const addpost({super.key});

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final databaseref = FirebaseDatabase.instance.ref("test");
  bool loading = false;
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add post"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 4,
              controller: postcontroller,
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
              final id = DateTime.now().millisecondsSinceEpoch.toString();
              databaseref.child(id).set({
                'title': postcontroller.text.toString(),
                "id": id
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
            },
          )
        ],
      ),
    );
  }
}
