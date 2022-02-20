import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_account_table.dart';
import "package:flutter/material.dart";

import '../transfer_screen.dart';

class BodyChoose extends StatelessWidget {
  const BodyChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    double rowHeight = 0.05 * size.height;
    final TableRow rowSpacer = TableRow(children: [
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
      SizedBox(
        height: rowHeight,
      ),
    ]);

    return Column (
      children: <Widget>[
        ChooseAccountTable(),
        ButtonConfirmButton(
          text: "Continue to Transfer",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TransferScreen(choosenUser: User.getSelectedUser())
              ),
            );
          },
        )
      ],
    );
  }
}