// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  String text = "";
  RegularText(String text) {
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: 'LatoRegular', fontSize: 15.0),
    );
  }
}
