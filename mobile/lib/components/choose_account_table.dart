import 'dart:developer';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/components/text_account_attribute.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class User {
  String name;
  String phone;
  int exp;
  // TODO kayaknya harus ada atribut id buat nandain user yang mana nanti

  User(this.name, this.phone, this.exp);
  factory User.fromJson(dynamic json) {
    return User(
        json['name'] as String,
        json['phone'] as String,
        json['exp'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.name}, ${this.phone}, ${this.exp}}';
  }
}

class ChooseAccountTable extends StatefulWidget {
  ChooseAccountTable({Key? key}) : super(key: key);

  static const dummyData = [
    {"name": "Zerso", "phone": "0812345670", "exp": 15000},
    {"name": "Satu", "phone": "0812345671", "exp": 18000},
    {"name": "Dua", "phone": "0812345672", "exp": 25000},
    {"name": "Satu", "phone": "0812345670", "exp": 15000},
    {"name": "Satu", "phone": "0812345671", "exp": 18000},
    {"name": "Dua", "phone": "0812345672", "exp": 25000},
  ];

  @override
  State<ChooseAccountTable> createState() => _ChooseAccountTableState();
}

class _ChooseAccountTableState extends State<ChooseAccountTable> {
  List<User> users = ChooseAccountTable.dummyData.map((e) =>
      User.fromJson(e)).toList();
  List<User> usersFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  
  @override
  void initState() {
    super.initState();
    usersFiltered = users;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    int selectedIndex = -1;
    log('data: $_searchResult');
    // dataToTable(size);

    return Column(
      children: [
        SearchBox(
            hintText: 'Search account', 
            onChanged: (value) {
              setState(() {
                _searchResult = value;
                usersFiltered = users.where((user) =>
                    (user.name.toLowerCase().contains(_searchResult))||
                        user.phone.contains(_searchResult)).toList();
              });
            }
        ),
        Container(
          width: .8 * size.width,
          height: .6598 * size.height,
          child: SingleChildScrollView (
            child: DataTable(
                border: TableBorder.all(color: primaryBlue),
                dividerThickness: 0,
                dataRowHeight: 0.12 * size.height,
                headingRowHeight: 0,
                horizontalMargin: 0,
                columnSpacing: 0,
                showCheckboxColumn: false,
                columns: const <DataColumn> [
                  DataColumn(label: Text('a')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                ],
                rows: List.generate(usersFiltered.length, (index) =>
                  DataRow(
                    selected: 0 == selectedIndex,
                    onSelectChanged: (val) {
                      setState(() {
                        selectedIndex = index;
                        log('idx: $index');
                      });
                    },
                    cells: <DataCell>[
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
                          DataCell(TextName(text: usersFiltered[index].name)),
                          DataCell(TextPhone(text:  usersFiltered[index].phone)),
                          DataCell(TextExp(text:  usersFiltered[index].exp.toString())),
                    ]
                  )
                )
            ),
          ),
        ),
      ],
    );
  }
}