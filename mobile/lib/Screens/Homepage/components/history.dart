import "package:flutter/material.dart";
import 'package:cakrawala_mobile/utils/history-api.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/history_container.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TransactionHistory> transData = [];

  @override
  void initState() {
    loadState();
    super.initState();
  }

  void loadState() async {
    await HistoryAPI.getHistoryAdmin().then((data) {
      setState(() {
        transData.addAll(data);
      });
    });
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Type')),
      const DataColumn(label: Text('Dest ID')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Created At'))
    ];
  }

  List<DataRow> _createRows() {
    List<DataRow> rows = [];
    for (var t in transData) {
      rows.add(_createRow(t.transactionType, t.destID, t.nominal, t.createdAt));
    }

    return rows;
  }

  DataRow _createRow(
      String type, String destID, String nominal, String createdAt) {
    return DataRow(cells: [
      DataCell(Text(type)),
      DataCell(Text(destID)),
      DataCell(Text(nominal)),
      DataCell(Text(createdAt)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return HistoryContainer(
      child: ListView(
        shrinkWrap: true,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _createDataTable(),
            ),
          )
        ],
      ),
    );
  }
}
