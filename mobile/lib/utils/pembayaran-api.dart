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

  static Future<CustomHttpResponse<Map<String, dynamic>>> getUserInformation() async {
    var header = await _getHeaders();
    var response = await http.get(Uri.parse(Constant.URL_BE+"/self"), headers: header);
    var bodyresp = json.decode(response.body) as Map<String, dynamic>;
    if(response.statusCode == 200){
      return CustomHttpResponse(response.statusCode, "", bodyresp);
    } else if(response.statusCode < 500){
      return CustomHttpResponse(response.statusCode, bodyresp['message'], json.decode('{}') as Map<String, dynamic>);
    }
    return CustomHttpResponse(response.statusCode, response.body, json.decode('{}') as Map<String, dynamic>);
  }
}