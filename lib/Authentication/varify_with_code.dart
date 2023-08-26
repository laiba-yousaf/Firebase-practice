

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

import '../Post/postscreen.dart';
import '../Widgets/roundbutton.dart';

class varificationnumber extends StatefulWidget {
  final String varify_ID;

  const varificationnumber({super.key, required this.varify_ID});

  @override
  State<varificationnumber> createState() => _varificationnumberState();
}

class _varificationnumberState extends State<varificationnumber> {
  final varifyctrl = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Varify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: varifyctrl,
                decoration: const InputDecoration(hintText: "6 code digit")),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Varify",
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final Credential = PhoneAuthProvider.credential(
                    verificationId: widget.varify_ID,
                    smsCode: varifyctrl.text.toString(),
                  );
                  try {
                    await auth.signInWithCredential(Credential);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const postscreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                      Utils().toastmessage(e.toString());
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
