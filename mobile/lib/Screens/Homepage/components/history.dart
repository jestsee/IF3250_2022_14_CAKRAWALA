import 'dart:developer';

import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';
import "package:flutter/material.dart";
import 'package:cakrawala_mobile/utils/history-api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../components/text_account_template.dart';
import '../../../constants.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/wallet_info.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => HistoryState();
}

class HistoryState extends State<History> {
  late Future<List<TransactionHistory>> _transData;
  List<TransactionHistory> transData = [];

  @override
  void initState() {
    _transData = loadState();
    super.initState();
  }

  Color whatColor(String type, bool isDebit) {
    if (type == "Top Up Completed" || (type == "Transfer" && !isDebit)) {
      return Colors.lightGreen;
    } else if (type == "Top Up Pending") {
      return Colors.orangeAccent;
    }
    return Colors.red;
  }

  String nominal(String type, String nominal, bool isDebit) {
    if (type.substring(0,6) == "Top Up" || (type == "Transfer" && !isDebit)) {
      return "+$nominal";
    } return "-$nominal";
  }

  Future<List<TransactionHistory>> loadState() async {
    List<TransactionHistory> _data = [];
    await HistoryAPI.getHistoryAdmin().then((data) {
      setState(() {
        transData = data;
        transData = transData.reversed.toList();
      });
      _data = data;
    });
    return _data;
  }

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  Widget listView() {
    return FutureBuilder<List<TransactionHistory>>(
        future: _transData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(bottom: handleOverflow(context)),
              child: ListView.builder(
                itemCount: transData.length,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(10)),
                  // color: selectedIndex == index? const Color(0xFFD6D6D6): Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    minVerticalPadding: 0,
                    horizontalTitleGap: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.all(0),
                    tileColor: const Color(0xfff0f0f0),
                    // leading: Container(width: 8, color: Colors.red,),
                    // minLeadingWidth: 16,
                    title: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                  ),
                                  color: whatColor(
                                    transData[index].transactionType,
                                    transData[index].isDebit
                                  ) // TODO
                                ),
                              ),
                              Container(
                                width: 65,
                                height: 65,
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 0.25,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextAccountTemplate(
                                      text: DateFormat('dd').format(transData[index].createdAt),
                                      align: TextAlign.left,
                                      weight: FontWeight.w800,
                                      size: 22,
                                      color: black
                                    ),
                                    TextAccountTemplate(
                                        text: DateFormat.MMMM().format(transData[index].createdAt),
                                        align: TextAlign.left,
                                        weight: FontWeight.w700,
                                        size: 14,
                                        color: Colors.black38
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    transData[index].transactionType,
                                    style: const TextStyle (
                                        fontSize: 17,
                                        letterSpacing: 0.1,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextAccountTemplate(
                                    text: DateFormat('yyyy HH:mm:ss').format(transData[index].createdAt),
                                    align: TextAlign.left,
                                    weight: FontWeight.w500,
                                    size: 14,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: TextAccountTemplate(
                              text: nominal(
                                  transData[index].transactionType,
                                  transData[index].nominal,
                                  transData[index].isDebit
                              ),
                              align: TextAlign.left,
                              weight: FontWeight.w600,
                              size: 18,
                              color: whatColor(
                                  transData[index].transactionType,
                                  transData[index].isDebit
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            log('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return SizedBox(
      width: .9 * size.width,
      height: .36 * size.height,
      child: listView(),
    );
  }
}
