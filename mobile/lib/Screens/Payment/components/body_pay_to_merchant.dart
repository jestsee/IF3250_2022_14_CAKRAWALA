import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import "package:flutter/material.dart";

class BodyPayToMerchant extends StatelessWidget {
  const BodyPayToMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 0, bottom: 15),
          child: Text(
            "Choose the merchant that you want to pay.",
            style: TextStyle(
              color: Color(0xE5E5E5E5),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
        ChooseMerchantTable(),
        ButtonConfirmButton(text: "Continue To Payment", press: () {})
      ],
    );
  }
}
