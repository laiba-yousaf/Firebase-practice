import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/Widgets/roundbutton.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? image;
  final picker = ImagePicker();
  final fireStore = FirebaseFirestore.instance.collection("Users");
  bool loading = false;

  Future getImageGallary() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    // firebase_storage.FirebaseStorage instance =
    //     firebase_storage.FirebaseStorage.instance;

    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print("file not picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPLOAD IMAGE"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallary();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Icon(Icons.image),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Upload",
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref("/foldername/" + DateTime.now().millisecondsSinceEpoch.toString()

                      );
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(image!.absolute);

                  await Future.value(uploadTask).then(
                    (value)async {
                      var newUrl = await ref.getDownloadURL();
                      String Id =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      fireStore.doc(Id).set(
                          {"title": newUrl.toString(), "id": Id}).then((value) {
                        setState(() {
                          loading = false;
                          Utils().toastmessage("uploaded");
                        });
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                          Utils().toastmessage(error.toString());
                        });
                      });
                    },
                  ).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                      Utils().toastmessage(error.toString());
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
