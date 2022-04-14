import 'dart:convert';
import 'dart:io';

import 'package:cakrawala_mobile/utils/custom-http-response.dart';
import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

class PembayaranAPI{
  static Future<Map<String, String>> _getHeaders() async{
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION : token.getToken()
    };
    return map;
  }

  static Future<CustomHttpResponse> payToMerchant(int id, int amount, String address, String bank ) async {
    var header = await _getHeaders();
    var body = {
      "address": address,
      "amount": amount,
      "bankAccount": bank,
      "merchant_id": id
    };

    var response  = await http.post(
        Uri.parse(Constant.URL_BE+"/pay-merchant"),
        body: json.encode(body),
        headers: header
    );

    var bodyresp = json.decode(response.body) as Map<String, dynamic>;

    return CustomHttpResponse(response.statusCode, bodyresp['message'], json.decode(response.body) as Map<String, dynamic>);
  }
}