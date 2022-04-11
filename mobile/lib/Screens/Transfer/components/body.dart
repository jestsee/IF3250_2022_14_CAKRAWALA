// ignore_for_file: prefer_const_constructors
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
// import 'package:cakrawala_mobile/components/choose_account_table2.dart';
import 'package:cakrawala_mobile/components/circle_profile_icon.dart';
import 'package:cakrawala_mobile/components/enter_amount_input.dart';
import 'package:cakrawala_mobile/components/user_profile_container.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import "package:flutter/material.dart";

import '../../../components/choose_account_table1.dart';

class Body extends StatelessWidget {
  final User choosenUser;
  const Body({Key? key, required this.choosenUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column (
        children: <Widget>[
          SizedBox(
            height: size.height * 0.05,
          ),
          CircleIcon(
            textName: choosenUser.name,
            press: () {},
            textColor: Colors.white,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          WhiteFieldContainer(
            child: UserProfileContainer(
              name: choosenUser.name,
              address: "",
              email: choosenUser.email
            )
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          EnterAmountInput(
            hintText: "Enter the amount to transfers",
            onChanged: (value) {},
          ),
          ButtonConfirmButton(
            text: "Confirm Transfer",
            press: (){
              currentUser = User(-1, "Unknown", "-1", -1, "Unknown");
            }),
        ],
    );
  }
}
