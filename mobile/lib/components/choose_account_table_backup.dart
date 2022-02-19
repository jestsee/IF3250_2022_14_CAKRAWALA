import 'dart:developer';

import 'package:cakrawala_mobile/components/text_account_attribute.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class ChooseAccountTable extends StatelessWidget {
  ChooseAccountTable({Key? key}) : super(key: key);

  final rows = <TableRow>[];
  static const dummyData = [
    {"name": "hah", "phone": "0812345670", "exp": 15000},
    {"name": "Satu", "phone": "0812345671", "exp": 18000},
    {"name": "Dua", "phone": "0812345672", "exp": 25000},
    {"name": "Satu", "phone": "0812345670", "exp": 15000},
    {"name": "Satu", "phone": "0812345671", "exp": 18000},
    {"name": "Dua", "phone": "0812345672", "exp": 25000},
  ];

  void dataToTable(size) {
    for (var data in dummyData) {
      log('data: $data');
      rows.add(TableRow(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0.1 * size.height
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                Image.network(
                  'https://picsum.photos/250?image=9',
                  height: 0.13 * size.width,
                  width: 0.13 * size.width,
                ),
              ),
            ),
          ),
          Text(
            data['name'].toString(),
            textAlign: TextAlign.left,
            style: TextStyle (
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.white
            ),
          ),
          Text(
            data['phone'].toString(),
            textAlign: TextAlign.left,
            style: TextStyle (
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Colors.white
            ),
          ),
          Text(
            data['exp'].toString(),
            textAlign: TextAlign.right,
            style: TextStyle (
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white
            ),
          ),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    double rowHeight = 0.05 * size.height;
    // dataToTable(size);

    return DataTable(
      border: TableBorder.all(color: primaryBlue),
      dividerThickness: 0,
      dataRowHeight: 0.12 * size.height,
      headingRowHeight: 0,
      horizontalMargin: 0,
      columnSpacing: 0,
      columns: const <DataColumn> [
        DataColumn(label: Text('a')),
        DataColumn(label: Text('asd')),
        DataColumn(label: Text('asd')),
        DataColumn(label: Text('asd')),
      ], rows: dummyData.map((e) {
        return DataRow(cells: <DataCell>[
          DataCell(
            Align (
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                Image.network(
                  'https://picsum.photos/250?image=9',
                  height: 0.13 * size.width,
                  width: 0.13 * size.width,
                ),
              ),
            ),
          ),
          DataCell(TextName(text:  e['name'].toString())),
          DataCell(TextPhone(text:  e['phone'].toString())),
          DataCell(TextExp(text:  e['exp'].toString())),
        ]
        );
    }).toList()
    );
  }
}