import 'package:cakrawala_mobile/Screens/Payment/components/body_confirm_payment.dart';
import 'package:cakrawala_mobile/Screens/Payment/components/body_pay_to_merchant.dart';
import 'package:cakrawala_mobile/Screens/Payment/pay_to_merchant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  const ConfirmPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: CustomAppBar(
        text: "Confirm Payment",
      ),
      body: PayToMerchantScreen(),
    );
  }
}
