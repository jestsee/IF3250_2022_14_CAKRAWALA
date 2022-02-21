
import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';
import "package:flutter/material.dart";
import 'package:cakrawala_mobile/constants.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: AppBar(
        titleSpacing: 40,
        title: const Text(
          'Home',
          style: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.white, fontSize: 20),
        ),
      ),

      body: Column(
        children: const <Widget>[
          WhiteFieldContainer(
            child: 
            WalletInfo(),
          ),
          Text("Transactions"),

        ]
      ),
    );
  }
}
