import 'package:cakrawala_mobile/Screens/Payment/components/body_invoice.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class InvoiceScreen extends StatelessWidget {
  final double nominal;
  final double points;
  final String namaMerchant;
  const InvoiceScreen({
    Key? key,
    required this.nominal,
    required this.points,
    required this.namaMerchant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: CustomAppBar(text: "Invoice"),
      body: BodyInvoice(
        namaMerchant: namaMerchant,
        nominal: nominal,
        points: points,
      ),
    );
  }
}
