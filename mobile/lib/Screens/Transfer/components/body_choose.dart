import 'package:fluttertoast/fluttertoast.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_account_table.dart';
import "package:flutter/material.dart";

import '../../../components/choose_merchant_table.dart';
import '../../../components/enter_amount_input.dart';
import '../../../components/text_account_template.dart';
import '../../../constants.dart';
import '../transfer_screen.dart';

class BodyChoose extends StatelessWidget {
  const BodyChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column (
      children: <Widget>[
        // ChooseAccountTable(),
        SizedBox(height: .1 * size.width),
        Center(
          child: Container(
            width: .68 * size.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: .02 * size.height,
                ),
                const TextAccountTemplate(
                  text: "RECEIVER'S PHONE NUMBER",
                  align: TextAlign.center,
                  weight: FontWeight.bold,
                  size: 14,
                  color: Color(0xFF565656),
                ),
                SizedBox(
                  height: .01 * size.height,
                ),
                Container(
                  width: .4 * size.width,
                  alignment: Alignment.center,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: black
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // amount = value == "" ? 0 : int.parse(value); // TODO
                    },
                  ),
                ),
                // SizedBox(
                //   height: .018 * size.height,
                // ),
                // const TextAccountTemplate(
                //   text: "You will get bonus points!",
                //   align: TextAlign.center,
                //   weight: FontWeight.w400,
                //   size: 14,
                //   color: Color(0xFF565656),
                // ),
                SizedBox(
                  height: .02 * size.height,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: .02 * size.height,
        ),
        EnterAmountInput(
          hintText: "Enter the amount to transfers",
          onChanged: (value) {},
        ),
        ButtonConfirmButton(
          text: "Continue to Transfer",
          press: () {
            User u = User.getSelectedUser();
            if (u.id == -1) {
              Fluttertoast.showToast(
                  msg: "Please choose account before continue",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 14.0
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TransferScreen(choosenUser: User.getSelectedUser())
                ),
              );
            }
          },
        )
      ],
    );
  }
}