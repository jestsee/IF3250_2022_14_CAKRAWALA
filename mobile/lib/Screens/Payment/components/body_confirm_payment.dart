import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/rounded_payment_detail_field.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';

class BodyConfirmPayment extends StatelessWidget {
  const BodyConfirmPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width),
        const RoundedPaymentDetail(),
        SizedBox(
          height: .03 * size.width,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: .1 * size.width),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
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
                    text: "Jl. Cisitu Lama IV",
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
                      text: "1234567 Bank Mandiri a/n Merchant 1",
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
            press: () {})
      ],
    );
  }
}
