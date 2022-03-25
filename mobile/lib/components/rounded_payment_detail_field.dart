import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedPaymentDetail extends StatelessWidget {
  final String nama;
  final int nominal;
  final int points;
  final bool amount;
  const RoundedPaymentDetail(
      {
        Key? key,
        required this.nama,
        required this.nominal,
        required this.points,
        this.amount = false
      }
  ) : super(key: key);

  Widget amountOrMerchant() {
    if(amount == false) {
      return TextAccountTemplate(
        text: nama,
        align: TextAlign.center,
        weight: FontWeight.w400,
        size: 22,
        color: black,
      );
    } else {
      return TextAccountTemplate(
        text: nama,
        align: TextAlign.center,
        weight: FontWeight.w400,
        size: 13,
        color: Color(0xFF565656),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: .68 * size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: .02 * size.height,
            ),
            amountOrMerchant(),
            SizedBox(
              height: .01 * size.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextAccountTemplate(
                  text: nominal.toString(),
                  align: TextAlign.center,
                  weight: FontWeight.w800,
                  size: 30,
                  color: black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: TextAccountTemplate(
                    text: "IDR",
                    align: TextAlign.center,
                    weight: FontWeight.w400,
                    size: 16,
                    color: black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: .005 * size.height,
            ),
            TextAccountTemplate(
              text: "You received $points points",
              align: TextAlign.center,
              weight: FontWeight.w400,
              size: 17,
              color: const Color(0xFF565656),
            ),
            SizedBox(
              height: .02 * size.height,
            ),
          ],
        ),
      ),
    );
  }
}
