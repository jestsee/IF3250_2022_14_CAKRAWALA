
import 'package:cakrawala_mobile/Screens/Homepage/homepage_screen.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/rounded_payment_detail_field.dart';
import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class InvoiceText extends StatelessWidget {
  final String text;
  const InvoiceText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextAccountTemplate(
      text: text,
      align: TextAlign.right,
      weight: FontWeight.w400,
      size: 14,
      color: black,
    );
  }
}


class WhiteInvoiceContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  const WhiteInvoiceContainer({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteFieldContainer(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InvoiceText(text: title),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align (
                      alignment: FractionalOffset.bottomRight,
                      child: InvoiceText(text: subtitle),
                    )
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

class BodyInvoice extends StatelessWidget {
  const BodyInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: .05 * size.width,),
        RoundedPaymentDetail(
            nama: "AMOUNT",
            nominal: 1032.69,
            points: 100,
            amount: true,
        ),
        SizedBox(height: .05 * size.width),
        WhiteInvoiceContainer(title: "Merchant", subtitle: "Nama Merchant"),
        WhiteInvoiceContainer(title: "Invoice ID", subtitle: "123456"),
        WhiteInvoiceContainer(title: "Time", subtitle: "03 Dec 2021 16:26:09"),
        WhiteFieldContainer(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InvoiceText(text: "Products"),
                    ],
                  ),
                ],
              ),
            )
        ),
        ButtonConfirmButton(text: "Back To Home", press: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage()));
        })
      ],
    );
  }
}
