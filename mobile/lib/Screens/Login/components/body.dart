// ignore_for_file: prefer_const_constructors

import 'package:cakrawala_mobile/Screens/Login/components/components.dart';
import 'package:cakrawala_mobile/Screens/Signup/signup_screen.dart';
import 'package:cakrawala_mobile/components/have_an_account_check.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/rounded_input_field.dart';
import 'package:cakrawala_mobile/components/rounded_password_field.dart';
import 'package:cakrawala_mobile/components/text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Background(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              "assets/images/login.png",
              height: size.height * 0.2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedInputField(
              hintText: "Enter Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
              textColor: Colors.black,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            HaveAnAccountCheck(press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            }),
          ]),
    );
  }
}
