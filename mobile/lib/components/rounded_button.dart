import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = white,
      this.textColor = black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
