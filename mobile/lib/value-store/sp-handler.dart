import 'package:cakrawala_mobile/value-store/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SharedPreferenceHandler {
  late SharedPreferences sp;
  SharedPreferenceHandler(){
    init();
  }

  void init() async{
    this.sp = await SharedPreferences.getInstance();
  }

  Future<bool> setToken(token) async {
    try{
      await this.sp.setString("token", token);
      return true;
    }on Exception catch(e){
      print(e.toString());
      return false;
    }
  }

  String getToken() {
    var token = this.sp.getString("token");
    if(token != null){
      return token;
    }
    return "";
  }

  Future<bool> isTokenActive() async{
    var token = getToken();
    var response = await http.get(
      Uri.parse(Constant.URL_BE + "/test"),
      headers: {
        "Authorization" : token
      }
    );
    return response.statusCode == 200;
  }

  Future<bool> revokeToken() async{
    try{
      await this.sp.setString("token", "");
      return true;
    }on Exception catch(e){
      print(e.toString());
      return false;
    }
  }

  static SharedPreferenceHandler getHandler(){
    return SharedPreferenceHandler();
  }
}