import 'dart:convert';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DriverDashboardController extends AppController {
  bool isDocumentVerified = false;
  String? token;
  int numOfVehicles = 0; // Variable to hold the number of vehicles

  String documentStatus = "";
  @override
  void onInit() {
    super.onInit();
    getDocumentStatus();
  }

  TokenController tokenContrller = Get.put(TokenController());

  Future<int?> fetchNumOfVehicles() async {
    try {
      String? tok = await tokenContrller.retriveToken();
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/totalVehicle'),
        headers: {
          'Authorization': 'Bearer $tok',
          'Content-Type': 'application/json',
        },
      );

      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        numOfVehicles = responseJson['totalVehicles'];
        print("$numOfVehicles, numOfvehicle");
        update();
        return numOfVehicles; // Update the variable
        // Notify listeners about the update
      } else {
        print("Failed to fetch vehicles: ${response.statusCode}");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
    }
    return null;
  }

  Future<void> removeTokenFromLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    bool results = await pref.remove("token");
    print("token removed: $results");
  }

  Future<void> getDocumentStatus() async {
    try {
      String? tok = await tokenContrller.retriveToken();
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/getDocumentStatus'),
        headers: {
          'Authorization': 'Bearer $tok',
          'Content-Type': 'application/json',
        },
      );

      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);

        print("$numOfVehicles, numOfvehicle"); // Update the variable
        documentStatus = responseJson['']['documentStatus'];
        print(responseJson['']['documentStatus']);
        isDocumentVerified = documentStatus.toLowerCase() == "unverified";
        update();
      } else {
        print("Failed to fetch vehicles: ${response.statusCode}");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
    }
  }
}
