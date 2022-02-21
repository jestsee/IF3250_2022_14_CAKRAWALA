import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/icon_button.dart';
import 'package:cakrawala_mobile/constants.dart';
import "package:flutter/material.dart";

class WalletInfo extends StatelessWidget {
  const WalletInfo({
    Key? key,
  }) : super(key: key);
  static const double pad = 0.035;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WhiteFieldContainer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Text("Wallet Balance"),
          SizedBox(height: size.height * pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("16,000"),
              Text("idr"),
            ],
          ),
          SizedBox(height: size.height * pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Text("6000 points"),
              Text("50 rewards"),
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
