import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<Map> login(
      {required String username, required String password,},) async {
    try {
      var url =
          Uri.parse('https://celd.josephadegbola.com/wp-json/route/v2/auth');
      Map body = {
        "username": username,
        "password": password,
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
      return {};
  }

  Future<Map> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      var url = Uri.parse(
          "https://celd.josephadegbola.com/wp-json/route/v2/addcustomer");
      Map body = {
        "email": email,
        "username": username,
        "password": password,
      };
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body);
        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }
}
