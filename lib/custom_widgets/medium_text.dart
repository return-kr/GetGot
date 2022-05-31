import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  String text = "";
  MediumText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: 'LatoRegular', fontSize: 20.0),
    );
  }
}