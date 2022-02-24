import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/icon_button.dart';
import 'package:cakrawala_mobile/constants.dart';

import "package:flutter/material.dart";

class WalletInfo extends StatelessWidget {
  const WalletInfo({
    Key? key,
  }) : super(key: key);
  static const double pad = 0.035;
  static const balance = 50000;
  static const points = 6000;
  static const rewards = 50;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WhiteFieldContainer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Text("Wallet Balance", 
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.bold,
            fontSize: 16)),
          SizedBox(height: size.height * pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Text(balance.toString(), 
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w900,
                  fontSize: 30)),
              ),
              const Text("IDR",
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
            ],
          ),
          SizedBox(height: size.height * pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Text("$points points",
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),
              Text("$rewards rewards",
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomIconButton(
                text: "Pay",
                icon_: Icons.monetization_on_outlined,
                textColor: white,
                color: black,
                press: () {},
              ),
              CustomIconButton(
                text: "Transfer",
                icon_: Icons.arrow_circle_up_rounded,
                textColor: white,
                color: black,
                press: () {},
              ),
              CustomIconButton(
                text: "Top Up",
                icon_: Icons.add,
                textColor: white,
                color: black,
                press: () {},
              ),
            ],
          ),
        ]));
  }
}
