import 'package:cakrawala_mobile/components/bottom_confirm_button.dart';
import 'package:cakrawala_mobile/components/choose_account_table.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import "package:flutter/material.dart";

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
        SearchBox(
          hintText: "Search account",
          onChanged: (value) {}
        ),
        SizedBox(
          height: 0.02 * size.height,
        ),
        // Container(
        //   width: 0.8 * size.width,
        //   child: Table(
        //     columnWidths: {
        //       0: IntrinsicColumnWidth(),
        //       1: IntrinsicColumnWidth(),
        //       2: IntrinsicColumnWidth(),
        //       3: IntrinsicColumnWidth(),
        //     },
        //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        //     children: [
        //       // first table row
        //       TableRow(
        //         children: [
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(10.0),
        //               child:
        //               Image.network(
        //                 'https://picsum.photos/250?image=9',
        //                 height: 0.13 * size.width,
        //                 width: 0.13 * size.width,
        //               ),
        //             ),
        //           ),
        //           Text(
        //             'Nama',
        //             textAlign: TextAlign.left,
        //             style: TextStyle (
        //                 fontWeight: FontWeight.w800,
        //                 fontSize: 16,
        //                 color: Colors.white
        //             ),
        //           ),
        //           Text('0812345678',
        //             textAlign: TextAlign.left,
        //             style: TextStyle (
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 13,
        //                 color: Colors.white
        //             ),
        //           ),
        //           Text('16000',
        //             textAlign: TextAlign.right,
        //             style: TextStyle (
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 14,
        //                 color: Colors.white
        //             ),
        //           ),
        //         ],
        //       ),
        //
        //       // space each row
        //       rowSpacer,
        //       // third table row
        //       rowSpacer,
        //
        //       // .... // add other rows here
        //     ],
        //   ),
        // ),
        Expanded(
          child: ListView(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ChooseAccountTable(),
              )
            ],
          ),
        ),
        ButtonConfirmButton(
          text: "Continue to Transfer",
          press: () {}
        )
      ],
    );
  }
}