import 'package:cakrawala_mobile/Screens/Login/login_screen.dart';
import 'package:cakrawala_mobile/Screens/Signup/components/background.dart';
import 'package:cakrawala_mobile/components/have_an_account_check.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/rounded_input_field.dart';
import 'package:cakrawala_mobile/components/rounded_password_field.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "SIGN UP",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Image.asset(
          "assets/images/signup.png",
          height: size.height * 0.15,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        RoundedInputField(hintText: "Email", onChanged: (value) {}),
        RoundedPasswordField(onChanged: (value) {}),
        RoundedInputField(hintText: "Full Name", onChanged: (value) {}),
        RoundedInputField(hintText: "Phone Number", onChanged: (value) {}),
        RoundedButton(
          text: "SIGN UP",
          press: () {},
          textColor: Colors.black,
        ),
        HaveAnAccountCheck(
          login: false,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        )
      ],
    ));
  }
}
