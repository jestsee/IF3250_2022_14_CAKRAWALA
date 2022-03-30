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

  late String tester;

  @override
  void initState() {
    loadState();
    super.initState();
  }

  void loadState() {
    HistoryAPI.getHistoryAdmin().then((data) => {
          setState(() {
            transData = data;
            tester = transData.length.toString();
          })
        });

    tester = transData.length.toString();
    print("PRINT loadState getHistoryAdmin MASUK");
  }

  @override
  Widget build(BuildContext context) {
    return HistoryContainer(
      child: SizedBox(
        height: 190,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Android Cupcake"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Android Donus"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tester),
            ),
          ],
        ),
      ),
    );
  }
}
