import 'package:cakrawala_mobile/components/text_account_template.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';

import '../Screens/Homepage/components/white_text_field_container.dart';

class RoundedPaymentDetail extends StatelessWidget {
  const RoundedPaymentDetail({Key? key}) : super(key: key);

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
            const TextAccountTemplate(
              text: "Merchant 1",
              align: TextAlign.center,
              weight: FontWeight.w400,
              size: 22,
              color: black,
            ),
            SizedBox(
              height: .01 * size.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                TextAccountTemplate(
                  text: "1,032.69",
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
            const TextAccountTemplate(
              text: "Get 1000 points",
              align: TextAlign.center,
              weight: FontWeight.w400,
              size: 17,
              color: black,
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
