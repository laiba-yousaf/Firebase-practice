import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Authentication/varify_with_code.dart';
import 'package:firebase_project/Widgets/roundbutton.dart';
import 'package:firebase_project/utils/utils.dart';
import 'package:flutter/material.dart';

class authphone extends StatefulWidget {
  const authphone({super.key});

  @override
  State<authphone> createState() => _authphoneState();
}

class _authphoneState extends State<authphone> {
  final phonectrl = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication with phone"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
             // keyboardType: TextInputType.number,
                controller: phonectrl,
                decoration: const InputDecoration(hintText: "+92 1234578")),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "login",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  auth.verifyPhoneNumber(
                      phoneNumber: phonectrl.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastmessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => varificationnumber(
                                      varify_ID: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastmessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
