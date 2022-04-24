import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

import '../components/number_formatter.dart';

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
        Uri.parse(Constant.URL_BE + "/transaction-history"),
        headers: header);
    var bodyResp = json.decode(response.body);

    // print(bodyResp["data"]);

    List<TransactionHistory> transHistory = [];
    late String type;

    if (response.statusCode == 200) {
      for (var t in bodyResp["data"]) {
        // Classify transaction type
        if (t["MerchantID"] == null && t["FriendID"] == null && t["Status"]!="completed") {
          type = "Top Up Pending";
        } else if (t["MerchantID"] == null && t["FriendID"] == null && t["Status"]=="completed") {
          type = "Top Up Completed";
        } else if (t["MerchantID"] != null && t["FriendID"] == null) {
          type = "Pay Merchant";
        } else if (t["MerchantID"] == null && t["FriendID"] != null ) {
          type = "Transfer";
        } else {
          type = "Error";
        }

        var formatter = NumberFormatter();

        // print("The transaction type is " + type.toUpperCase());
        String destID = t["UserID"].toString();
        String nominal = formatter.formatNumber(t["Amount"].toString());
        String createdAt = t["createdAt"].toString();
        bool isDebit = t["IsDebit"];
        var parsedDate = DateTime.parse(t["createdAt"]).toLocal();
        // log(parsedDate.toString());

        TransactionHistory trans =
            TransactionHistory(type, destID, nominal, parsedDate, isDebit);
        transHistory.add(trans);

        // print(createdAt.split('T')[0]);


      }
    }

    return transHistory;
  }
}

class TransactionHistory {
  final String transactionType, destID, nominal;
  final DateTime createdAt;
  final bool isDebit;
  TransactionHistory(
      this.transactionType, this.destID, this.nominal, this.createdAt, this.isDebit);
}
