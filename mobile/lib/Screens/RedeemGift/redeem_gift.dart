import 'package:cakrawala_mobile/Screens/RedeemGift/components/body_redeem_gift.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/choose_gift_table.dart';

class RedeemGift extends StatelessWidget {
  const RedeemGift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Gift.resetGift();
        return Future.value(true);
      },
      child: const Scaffold(
        backgroundColor: deepSkyBlue,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          text: "Redeem Gifts",
          center: true,
          backButton: false,
        ),
        body: BodyRedeemGift(),
      ),
    );
  }
}
