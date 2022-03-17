import 'dart:convert';
import 'dart:io';

import 'package:cakrawala_mobile/utils/custom-http-response.dart';
import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:cakrawala_mobile/value-store/sp-handler.dart';
import 'package:http/http.dart' as http;

class PointsAPI{
  static Future<Map<String, String>> _getHeaders() async{
    var token = await SharedPreferenceHandler.getHandler();
    var map = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.AUTHORIZATION : token.getToken()
    };
    return map;
  }

  static Future<CustomHttpResponse<bool>> payCalculatePoints(int amount) async {
    var header = await _getHeaders();
    var body = {
    "amount": amount
  };

    var response  = await http.post(
        Uri.parse(Constant.URL_BE+"/pay-calculate-points"),
        body: json.encode(body),
        headers: header
    );
    return CustomHttpResponse(response.statusCode, response.body, response.statusCode==200);
  }
}