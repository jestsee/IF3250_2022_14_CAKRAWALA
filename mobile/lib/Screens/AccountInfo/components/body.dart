import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/Screens/AccountInfo/components/custom_text.dart';
import "package:flutter/material.dart";

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(
        text: "Profile",
        center: true,
        backButton: false,
      ),
      body: Column(
        children: const <Widget>[
          CustomText(
            textString: "Name", 
            fontSize: 18),
          CustomText(
            textString: "Email", 
            fontSize: 18),
          CustomText(
            textString: "Phone", 
            fontSize: 18),
          CustomText(
            textString: "Balance", 
            fontSize: 18),
          CustomText(
            textString: "Point", 
            fontSize: 18),
          CustomText(
            textString: "EXP", 
            fontSize: 18),
          CustomText(
            textString: "Reward", 
            fontSize: 18),
        ],
      ),
    );
  }
}