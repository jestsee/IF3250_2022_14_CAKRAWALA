import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  final String textString;
  final double fontSize;
  const CustomText({
    Key? key, 
    required this.textString, 
    required this.fontSize})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: TextStyle(
        fontFamily: 'Mulish',
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: white,
      ),
    );
  }
}
