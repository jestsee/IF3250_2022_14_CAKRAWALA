import 'dart:ui';

import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import "package:flutter/material.dart";
import 'package:cakrawala_mobile/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Home"),
      body: Column(children:  <Widget>[
        const WhiteFieldContainer(
          child: WalletInfo(),
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 5, 0, 10),
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black
            ),

          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Scan',
              backgroundColor: Colors.black
            ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
              backgroundColor: Colors.black
            ),
        ],
      ),
    );
  }
}

