// ignore_for_file: prefer_const_constructors
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/circle_profile_icon.dart';
import 'package:cakrawala_mobile/components/enter_amount_input.dart';
import 'package:cakrawala_mobile/components/rounded_button.dart';
import 'package:cakrawala_mobile/components/user_info_text.dart';
import 'package:cakrawala_mobile/components/user_profile_container.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import "package:flutter/material.dart";

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    const Color blue = Color.fromRGBO(0, 162, 237, 1);

    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        titleSpacing: 40,
        title:
        Text (
          'Transfer',
          style: TextStyle(fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 20),),
        backgroundColor: blue,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding:
              EdgeInsets.symmetric(horizontal: 0.05 * size.width),
              child: BackButton(),)
        ],
      ),
      body: Column (
        children: <Widget>[
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleIcon(
            textName: "Contoh",
            press: () {},
            textColor: Colors.white,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          WhiteFieldContainer(
            child: UserProfileContainer(
              name: "Contoh Nama",
              address: "Jl. Contoh Alamat No. 10",
              email: "ContohEmail@gmail.com"
            )
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          EnterAmountInput(
            hintText: "Enter the amount to transfers",
            onChanged: (value) {},
          ),
          ButtonConfirmButton(text: "Confirm Transfer", press: (){})
        ],
      ),
    );
  }
}
