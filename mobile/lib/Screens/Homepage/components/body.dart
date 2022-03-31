import 'dart:ui';

import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';
import 'package:cakrawala_mobile/Screens/RedeemGift/redeem_gift.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import "package:flutter/material.dart";
import 'package:cakrawala_mobile/constants.dart';

import '../homepage_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentIndex = 0;

  void onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RedeemGift()),
      );
    }
  }

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
      bottomNavigationBar: FloatingNavbar(
        iconSize: 26,
        borderRadius: 24,
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 34),
        padding: const EdgeInsets.symmetric(vertical: 12),
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home_outlined),
          FloatingNavbarItem(icon: Icons.camera),
          FloatingNavbarItem(icon: Icons.card_giftcard_rounded),
          FloatingNavbarItem(icon: Icons.person)
        ],
        onTap: onItemTapped,
      ),
    );
  }
}

