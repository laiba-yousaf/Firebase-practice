import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/Firestore/firestore_add.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

final addctrl = TextEditingController();
final editctrl = TextEditingController();

class _FirestoreScreenState extends State<FirestoreScreen> {
  final fireStore = FirebaseFirestore.instance.collection("Users").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("Users");
  int selectedIndex = -1; // Initialize with an invalid index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          
          StreamBuilder(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();

              if (snapshot.hasError) return const Text("some error");

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                      trailing: PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 1) {
                            setState(() {
                              selectedIndex = index;
                            });
                            showMyDialog(
                              snapshot.data!.docs[index]['title'].toString(),
                              snapshot.data!.docs[index]['id'].toString(),
                              context,
                            );
                          }
                          if (value == 2) {
                            setState(() {
                              selectedIndex = index;
                            });
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .delete();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<int>(
                            value: 1,
                            child: ListTile(
                              title: Text("Edit"),
                              leading: Icon(Icons.edit),
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: ListTile(
                              title: Text("Delete"),
                              leading: Icon(Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const firestoreAdd()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(
      String title, String id, BuildContext context) async {
    editctrl.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update"),
          content: TextField(
            controller: editctrl,
            decoration: const InputDecoration(hintText: "Edit"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (selectedIndex != -1) {
                  ref.doc(id).update({"title": editctrl.text}).then((value) {
                    Utils().toastmessage("Updated");
                  }).onError((error, stackTrace) {
                    Utils().toastmessage(error.toString());
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
