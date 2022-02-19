import 'dart:developer';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/components/text_account_attribute.dart';
import 'package:cakrawala_mobile/constants.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  String phone;
  int exp;
  bool selected = false;

  User(this.id, this.name, this.phone, this.exp);
  factory User.fromJson(dynamic json) {
    return User(
        json['id'] as int,
        json['name'] as String,
        json['phone'] as String,
        json['exp'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.phone}, ${this.exp}}';
  }
}

class ChooseAccountTable extends StatefulWidget {
  ChooseAccountTable({Key? key}) : super(key: key);

  static const dummyData = [
    {"id": 0, "name": "Zerso", "phone": "0812345670", "exp": 15000},
    {"id": 1, "name": "Satu", "phone": "0812345671", "exp": 18000},
    {"id": 2,"name": "Dua", "phone": "0812345672", "exp": 25000},
    {"id": 3,"name": "Satu", "phone": "0812345670", "exp": 15000},
    {"id": 4,"name": "Satu", "phone": "0812345671", "exp": 18000},
    {"id": 5,"name": "Dua", "phone": "0812345672", "exp": 25000},
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

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    log('m: ${bottom}');
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    int selectedIndex = -1;
    bool isSelected = false;
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
          padding: EdgeInsets.only (
            // change 1
            bottom: handleOverflow(context),
          ),
          child: SingleChildScrollView (
            child: DataTable(
              // border: TableBorder.all(color: Colors.black),
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
                    selected: usersFiltered[index].selected,
                    onSelectChanged: (val) {
                      setState(() {
                        log('-------');
                        log('val: $val');
                        for (var u in usersFiltered) {
                          log('${u.id}: ${u.selected}');
                        }
                        log('bfr: $index ${usersFiltered[index].selected}');
                        selectedIndex = index;

                        // reset all selected when clicked
                        for (var u in users) {
                          u.selected = false;
                        }

                        // assign new selected value
                        if (usersFiltered[index].selected == false && val == false) {
                          log('masuk sini gan');
                          usersFiltered[index].selected = true;
                        } else {
                          usersFiltered[index].selected = val!;
                        }
                        log('aftr: $index ${usersFiltered[index].selected}');
                        log('s: $selectedIndex');
                        // TODO get id dari user berdasarkan selectedindex, pass ke BE
                      });
                    },
                    color: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.amber;
                      }
                    }),
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