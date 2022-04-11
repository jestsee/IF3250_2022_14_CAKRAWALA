import 'package:cakrawala_mobile/Screens/Transfer/components/body_input.dart';
import "package:flutter/material.dart";

import '../../components/custom_app_bar.dart';
import '../../constants.dart';

class InputPhoneNumberScreen extends StatelessWidget {
  const InputPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: deepSkyBlue,
        appBar: CustomAppBar(text: "Transfer"),
        body: BodyInput()
    );
  }
}
