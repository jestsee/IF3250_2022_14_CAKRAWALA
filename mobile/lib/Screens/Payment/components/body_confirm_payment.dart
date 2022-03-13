import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Payment/transaction_successful.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import 'package:cakrawala_mobile/components/rounded_payment_detail_field.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class BodyConfirmPayment extends StatelessWidget {
  final Merchant choosenMerchant;
  final double nominal;
  final double points;
  const BodyConfirmPayment({
    Key? key,
    required this.choosenMerchant,
    required this.nominal,
    required this.points
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width),
        RoundedPaymentDetail(
          nama: choosenMerchant.name,
          nominal: nominal,
          points: points,
        ),
        SizedBox(
          height: .03 * size.width,
        ),
        Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextAccountTemplate(
              text: "Address",
              align: TextAlign.left,
              weight: FontWeight.w400,
              size: 15,
            ),
            WhiteFieldContainer(
              round: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextAccountTemplate(
                  text: choosenMerchant.alamat,
                  align: TextAlign.left,
                  weight: FontWeight.w400,
                  size: 15,
                  color: black,
                ),
              )
            ),
            const TextAccountTemplate(
              text: "Account Number",
              align: TextAlign.left,
              weight: FontWeight.w400,
              size: 15,
            ),
            WhiteFieldContainer(
                round: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextAccountTemplate(
                    text: "${choosenMerchant.no_rek} a/n ${choosenMerchant.name}",
                    align: TextAlign.left,
                    weight: FontWeight.w400,
                    size: 15,
                    color: black,
                  ),
                )
            ),
          ],
        ),
        ButtonConfirmButton(
            text: "Finish Payment",
            press: () {
              // reset current merchant
              currentMerchant = Merchant(-1, "Unknown", "Unknown", -1);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionSuccessfulScreen(
                    namaMerchant: choosenMerchant.name,
                    nominal: nominal,
                    points: points,
                  )
                )
              );
            })
      ],
    );
  }
}
