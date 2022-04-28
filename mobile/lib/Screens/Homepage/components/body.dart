import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/history.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';
import 'package:cakrawala_mobile/Screens/RedeemGift/redeem_gift.dart';
import 'package:cakrawala_mobile/Screens/AccountInfo/account_info_screen.dart';
import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import "package:flutter/material.dart";
import 'package:cakrawala_mobile/constants.dart';


class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentIndex = 0;
  GlobalKey<WalletInfoState> walletKey = GlobalKey();
  GlobalKey<HistoryState> historyKey = GlobalKey();

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _currentIndex = index;
        });
        break;

      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const RedeemGift()),
        );
        break;

      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AccountInfo()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(text: "Home"),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), (){
            walletKey.currentState?.loadState();
            historyKey.currentState?.initState();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(children: <Widget>[
            WhiteFieldContainer(
              child: WalletInfo(key: walletKey,),
            ),
            SizedBox(height: .006 * size.height,),
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
            History(key: historyKey,),
          ]),
        ),
      ),
      bottomNavigationBar: FloatingNavbar(
        iconSize: 30,
        borderRadius: 24,
        selectedBackgroundColor: null,
        selectedItemColor: white,
        unselectedItemColor: Colors.white70,
        width: 0.9 * size.width,
        margin: const EdgeInsets.symmetric(vertical: 34),
        padding: const EdgeInsets.symmetric(vertical: 12),
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home_outlined),
          FloatingNavbarItem(icon: Icons.card_giftcard_rounded),
          FloatingNavbarItem(icon: Icons.person)
        ],
        onTap: onItemTapped,
      ),
    );
  }
}
