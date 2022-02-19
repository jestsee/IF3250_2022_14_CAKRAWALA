import 'package:cakrawala_mobile/Screens/Transfer/components/body.dart';
import 'package:cakrawala_mobile/Screens/Transfer/components/body_choose.dart';
import "package:flutter/material.dart";

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class ChooseTransferScreen extends StatelessWidget {
  const ChooseTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(text: "Choose Account"),
      body: BodyChoose()
    );
  }
}