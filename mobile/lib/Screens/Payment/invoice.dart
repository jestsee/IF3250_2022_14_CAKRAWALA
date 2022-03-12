import 'package:cakrawala_mobile/Screens/Payment/components/body_invoice.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: CustomAppBar(text: "Invoice"),
      body: BodyInvoice(),
    );
  }
}
