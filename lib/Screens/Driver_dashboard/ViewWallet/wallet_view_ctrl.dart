import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewWalletController extends AppController {
  TokenController tokenController = Get.put(TokenController());
  final passwordController = TextEditingController();
  final mywallet = TextEditingController();

  String? token;
  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }

  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token");
    return token;
  }

  int currentBalance = 0;

  Future<http.Response> getMyWallet(String password, String newToken) async {
    return await http.get(Uri.parse("${Config.apiUrl}/myWallet"), headers: {
      'Authorization': 'Bearer $newToken',
      'Content-Type': 'application/json',
    });
  }

  Future myWallet() async {
    String password = passwordController.text;
    String? mytoken = await tokenController.retriveToken();
    final response = await getMyWallet(password, mytoken!);
    final res = await getMyWallet(password, mytoken);
    if (res.statusCode == 200) {
      final response = json.decode(res.body);
      print("${response['msg']}: user profile");

      currentBalance = response['msg']['name'];

      alertSuccess("${response['msg']}");
    }
  
  else{
    print("Failed to get profile: ${res.statusCode}");
  }
}
}