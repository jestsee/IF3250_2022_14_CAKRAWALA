import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

import 'components/body_transaction_successful.dart';

class TransactionSuccessfulScreen extends StatelessWidget {
  const TransactionSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      body: BodyTransactionSuccessful(),
    );
  }
}
