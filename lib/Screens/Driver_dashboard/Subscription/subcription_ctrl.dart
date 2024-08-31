import 'dart:convert';
import 'dart:core';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DriverSubscriptionController extends AppController {
  TokenController tokens = Get.put(TokenController());

  var subscriptionPlans = <Map<String, dynamic>>[].obs;

  void initState() {
    super.onInit();
    getTokenAndLoadSubscriptionDetails();
    print("hello i am here");
    update();
  }

  void getTokenAndLoadSubscriptionDetails() async {
    String? myToken = await tokens.retriveToken();
    if (myToken != null) {
      subscriptionDetails(myToken);
      update();
    } else {
      print("No token found");
      // Handle the case where the token is null
    }
  }

  String name = "";
  String description = "";
  String price = "";

  Future<void> subscriptionDetails(String newToken) async {
    try {
      final response = await fetchSubscriptionPlans(newToken);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final subScriptionList = data['reservationTypeList'] as List<dynamic>;
        subscriptionPlans.value = subScriptionList.map((subscription) {
          return {
            'id': subscription['id'],
            'name': subscription['name'],
            'description': subscription['description'],
            'price': subscription['price'],
            'terms': subscription['terms'],
            'recommendation': subscription['subscription']
          };
        }).toList();
        update();
        print("$subscriptionPlans : your array");
      } else {
        print('Failed to load subscription plans');
      }
    } catch (e) {
      print("Error occurred while fetching subscriptionDetails: $e");
    }
  }

  Future<http.Response> fetchSubscriptionPlans(myToken) async {
    return await http.get(
      Uri.parse('${Config.apiUrl}/getAllReservationTtypes'),
      headers: {
        'Authorization': 'Bearer $myToken',
        'Content-Type': 'application/json',
      },
    );
  }
}

  // Future<void> getRides() async {
  //   try {
  //     final res = await ride();
  //     if (res.statusCode == 200) {
  //       final response = json.decode(res.body);
  //       final ridesList = response['msg'] as List<dynamic>;

  //       // Convert each ride to a map and add it to the rides list
  //       rides.value = ridesList.map((ride) {
  //         return {
  //           'id': ride['id'],
  //           'name': ride['name'],
  //           'description': ride['description'],
  //         };
  //       }).toList();

  //       update();
  //     } else {
  //       print("Failed to get rides: ${res.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error occurred while fetching rides: $e");
  //   }
  // }