import "package:flutter/material.dart";
import 'dart:developer';
import 'package:cakrawala_mobile/Screens/Homepage/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/text_account_attribute.dart';

Transaction currentTransaction = Transaction.fromJson(
    {
      "id_transaksi": -1,
      "nama_transaksi": "Unknown",
      "waktu": "Unknown",
      "jumlah": -1,
    }
);

class Transaction {
  int id;
  String name;
  String tanggal;
  int jumlah;
  bool selected = false;

  Transaction(this.id, this.name, this.tanggal, this.jumlah);
  factory Transaction.fromJson(dynamic json) {
    return Transaction(
      json['id_transaksi'] as int,
      json['nama_transaksi'] as String,
      json['waktu'] as String,
      json['jumlah'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.jumlah}}';
  }

  static Transaction getSelectedTransaction() {
    log('selected:${currentTransaction.name}');
    return currentTransaction;
  }
}

class ChooseTransaction extends StatefulWidget {
  ChooseTransaction({Key? key}) : super(key: key);

  @override
  State<ChooseTransaction> createState() => _ChooseTransactionState();
}

class _ChooseTransactionState extends State<ChooseTransaction> {
  List<Transaction> transactions = DummyDataTransaction().data.map((e) =>
      Transaction.fromJson(e)).toList();
  List<Transaction> transactionFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    transactionFiltered = transactions;
  }

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column(
      children: [
        Container(
          width: size.width,
          height: .6598 * size.height,
          padding: EdgeInsets.only (
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
                  DataColumn(label: Text('p')),
                  DataColumn(label: Text('a')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('p')),
                ],
                rows: List.generate(transactionFiltered.length, (index) =>
                    DataRow(
                    selected: transactionFiltered[index].selected,
                    onSelectChanged: (val) {
                      setState(() {
                        // hide keyboard when user selected
                        FocusScope.of(context).requestFocus(new FocusNode());

                        currentTransaction = transactionFiltered[index];
                        log('$currentTransaction');

                        // reset all selected when clicked
                        for (var u in transactions) {
                          u.selected = false;
                        }

                        // assign new selected value
                        if (transactionFiltered[index].selected == false && val == false) {
                          transactionFiltered[index].selected = true;
                        } else {
                          transactionFiltered[index].selected = val!;
                        }
                      });
                    },
                    color: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {return Color(0xFFD6D6D6);}
                    }),
                    cells: <DataCell>[
                      DataCell(Container(width: 0.08 * size.width,)),
                      DataCell(
                            Align (
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:
                                Image.network(
                                  'https://picsum.photos/250?image=${transactionFiltered[index].id}',
                                  height: 0.13 * size.width,
                                  width: 0.13 * size.width,
                                ),
                              ),
                            ),
                          ),
                      DataCell(TextName(text: transactionFiltered[index].name)),
                      DataCell(TextPhone(text:  transactionFiltered[index].tanggal)),
                      DataCell(TextExp(text:  transactionFiltered[index].jumlah.toString())),
                      DataCell(Container(width: 0.08 * size.width,)),
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
// class ListTransactions extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//    return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ListTile( title: Text("Top Up"),subtitle: Text("09 Mar 2022 - 20:28"),leading: Icon(Icons.add_circle_outline),trailing: Text("Rp. 10.000")),
//         ListTile( title: Text("Transfer"),subtitle: Text("8 Mar 2022 - 13:00 "), leading: Icon(Icons.call_made_outlined), trailing: Text("Rp. 10.000")),
//         ListTile( title: Text("Pay Merchant"),subtitle: Text("This is the time."), leading: Icon(Icons.add_shopping_cart_outlined), trailing: Icon(Icons.star)),
//         ListTile( title: Text("Top Up"),subtitle: Text("Cast your vote."), leading: Icon(Icons.add_circle_outline), trailing: Icon(Icons.star))
//       ],
//     );
//   }
// }