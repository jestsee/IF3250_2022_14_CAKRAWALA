import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  final String text;
  final Color color, textColor;
  const CustomAppBar(
      {Key? key,
        required this.text,
        this.color = primaryColor,
        this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size; // Screen height and width

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0.1 * size.width,
      title:
      Text (
        text,
        style: TextStyle(fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 20),),
      backgroundColor: deepSkyBlue,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 0.05 * size.width),
          child: const BackButton(),)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}