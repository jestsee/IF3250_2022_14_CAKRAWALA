import 'package:cakrawala_mobile/Screens/Homepage/components/white_text_field_container.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/icon_button.dart';
import 'package:cakrawala_mobile/Screens/Topup/topup_screen.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/utils/userinfo-api.dart';
import 'package:cakrawala_mobile/value-store/constant.dart';

import "package:flutter/material.dart";

import '../../../components/blurry-dialog.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({
    Key? key,
  }) : super(key: key);
  static const double pad = 0.035;
  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  String balance = "-";
  String points = "-";
  String rewards = "-";
  Map<String, dynamic> userData = {};
  @override
  void initState() {
    loadState();
    super.initState();
  }

  void loadState(){
    UserInfoAPI.getUserInformation()
        .then((data) {
          if(data.status==200){
            setState(() {
              balance=data.data['balance'].toString();
              points=data.data['point'].toString();
              rewards=data.data['exp'].toString();
              userData = data.data;
              print(data.data);
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WhiteFieldContainer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Text("Wallet Balance",
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.bold,
            fontSize: 16)),
          SizedBox(height: size.height * WalletInfo.pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Text(balance.toString(),
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w900,
                  fontSize: 30)),
              ),
              const Text("IDR",
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
            ],
          ),
          SizedBox(height: size.height * WalletInfo.pad),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("$points points",
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),
              Text("$rewards exp",
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomIconButton(
                text: "Pay",
                icon_: Icons.monetization_on_outlined,
                textColor: white,
                color: black,
                press: () {
                  _showDialog(context, "Coming Soon", "this feature coming soon");
                },
              ),
              CustomIconButton(
                text: "Transfer",
                icon_: Icons.arrow_circle_up_rounded,
                textColor: white,
                color: black,
                press: () {
                  _showDialog(context, "Coming Soon", "this feature coming soon");
                },
              ),
              CustomIconButton(
                text: "Top Up",
                icon_: Icons.add,
                textColor: white,
                color: black,
                press: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TopUpScreen(userInfo: userData,)
                  ));
                },
              ),
            ],
          ),
        ]));
  }

  _showDialog(BuildContext context, title, content){
    BlurryDialog bd = BlurryDialog(title, content, null);

    showDialog(context: context, builder: (BuildContext context){
      return bd;
    });
  }
}
