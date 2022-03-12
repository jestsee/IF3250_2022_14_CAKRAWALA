import 'package:fluttertoast/fluttertoast.dart';
import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_account_table.dart';
import "package:flutter/material.dart";

import '../transfer_screen.dart';

class BodyChoose extends StatelessWidget {
  const BodyChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        ChooseAccountTable(),
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
                  backgroundColor: Colors.grey,
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