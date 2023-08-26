import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({Key? key, required this.title, required this.onTap,this.loading=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 176, 212, 241),
        ),
        child:Center(
          child:loading?const CircularProgressIndicator(color:Colors.white ,strokeWidth: 3,) : Text(
            title,
            style: const TextStyle(color: Color.fromARGB(255, 253, 251, 251)),
          ),
        ),
      ),
    );
  }
}
