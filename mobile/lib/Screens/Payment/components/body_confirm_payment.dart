import 'package:cakrawala_mobile/Screens/Payment/transaction_successful.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_merchant_table.dart';
import 'package:cakrawala_mobile/components/rounded_payment_detail_field.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyConfirmPayment extends StatelessWidget {
  final Merchant choosenMerchant;
  const BodyConfirmPayment({Key? key, required this.choosenMerchant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width),
        RoundedPaymentDetail(
          nama: choosenMerchant.name,
          nominal: 1032.69,
          points: 100,
        ),
        SizedBox(
          height: .03 * size.width,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: .1 * size.width),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextAccountTemplate(
                text: "Address",
                align: TextAlign.left,
                weight: FontWeight.w400,
                size: 15,
              ),
              WhiteFieldContainer(
                round: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextAccountTemplate(
                    text: choosenMerchant.alamat,
                    align: TextAlign.left,
                    weight: FontWeight.w400,
                    size: 15,
                    color: black,
                  ),
                )
              ),
              TextAccountTemplate(
                text: "Account Number",
                align: TextAlign.left,
                weight: FontWeight.w400,
                size: 15,
              ),
              WhiteFieldContainer(
                  round: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10),
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
        ),
        ButtonConfirmButton(
            text: "Finish Payment",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionSuccessfulScreen()));
            })
      ],
    );
  }
}
