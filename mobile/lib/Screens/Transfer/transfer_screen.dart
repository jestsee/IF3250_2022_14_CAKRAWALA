import 'package:cakrawala_mobile/Screens/Transfer/components/body.dart';
import "package:flutter/material.dart";

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: CustomAppBar(text: "Transfer"),
    body: Body()
    );
  }
}