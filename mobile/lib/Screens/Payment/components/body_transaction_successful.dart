import 'package:cakrawala_mobile/Screens/Payment/invoice.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class BodyTransactionSuccessful extends StatelessWidget {
  final double nominal;
  final double points;
  final String namaMerchant;
  const BodyTransactionSuccessful({
    Key? key,
    required this.nominal,
    required this.points,
    required this.namaMerchant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Text(
              "Transaction Successful",
              style: TextStyle(
                color: white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        ButtonConfirmButton(
            text: "See Invoice",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InvoiceScreen(
                    namaMerchant: namaMerchant,
                    nominal: nominal,
                    points: points,
                  )
                )
              );
            },
        )
      ],
    );
  }
}
