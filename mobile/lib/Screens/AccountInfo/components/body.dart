import 'package:cakrawala_mobile/components/custom_app_bar.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:cakrawala_mobile/Screens/AccountInfo/components/custom_text.dart';
import 'package:cakrawala_mobile/utils/userinfo-api.dart';
import "package:flutter/material.dart";

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = "-";
  String name = "-";
  String phone = "-";
  String balance = "-";
  String points = "-";
  String exp = "-";
  // String rewards = "-";
  // TODO reward pake button
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    loadState();
    super.initState();
  }

  void loadState() async {
    await UserInfoAPI.getUserInformation().then((data) {
      setState(() {
        if (data.status == 200) {
          setState(() {
            email = data.data['email'];
            name = data.data['Name'];
            phone = data.data['Phone'];
            balance = data.data['balance'].toString();
            points = data.data['point'].toString();
            exp = data.data['exp'].toString();
            userData = data.data;
            print(data.data);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: deepSkyBlue,
      appBar: const CustomAppBar(
        text: "Profile",
        center: true,
        backButton: false,
      ),
      body: Column(
        children: const <Widget>[
          CustomText(textString: "Name", fontSize: 18),
          CustomText(textString: "Email", fontSize: 18),
          CustomText(textString: "Phone", fontSize: 18),
          CustomText(textString: "Balance", fontSize: 18),
          CustomText(textString: "Point", fontSize: 18),
          CustomText(textString: "EXP", fontSize: 18),
          CustomText(textString: "Reward", fontSize: 18),
        ],
      ),
    );
  }
}
