import 'package:firebase_project/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splashservices splashscreen = Splashservices();

  @override
  void initState() {
    super.initState();
    splashscreen.login(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
      "Firebase totrial",
      style: TextStyle(fontSize: 15),
    )));
  }
}
