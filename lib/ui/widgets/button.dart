import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.label, required this.onTap});

  final label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.teal),
        child: MyTextStyle3(label, 15),
      ),
    );
  }
}
