import 'dart:convert';
import 'dart:io';

import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

import 'package:cakrawala_mobile/utils/custom-http-response.dart';

class HistoryAPI {
  static Future<Map<String, String>> _getHeaders() async {
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION: token.getToken()
    };
    return map;
  }

  static Future<List<TransactionHistory>> getHistoryAdmin() async {
    var header = await _getHeaders();
    var response = await http.get(
        Uri.parse(Constant.URL_ADMIN + "/transaction-history-admin"),
        headers: header);
    var bodyResp = json.decode(response.body);

    print(bodyResp["data"]);

    List<TransactionHistory> transHistory = [];

    if (response.statusCode == 200) {
      for (var t in bodyResp["data"]) {
        // TODO
        // BUAT IF UNTUK NENTUIN TRANSACTION_TYPE
        String type = "topup";
        String destID = t["UserID"].toString();
        String nominal = t["Amount"].toString();
        TransactionHistory temp = TransactionHistory(type, destID, nominal);
        transHistory.add(temp);
      }

      TransactionHistory trans = TransactionHistory("topup", "100", "100000");
      transHistory.add(trans);
    }

    return transHistory;
  }
}

class TransactionHistory {
  final String transactionType, destID, nominal;
  TransactionHistory(this.transactionType, this.destID, this.nominal);
}
