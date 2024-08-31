import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/pushnotification/notification_ctrl.dart';
import 'package:get/get.dart';

class PushNotificationPage extends StatelessWidget{
  @override
  Widget build(Object context) {
  return  GetBuilder<PushNotificationController>(
      builder: (controller) => Scaffold(

body: Center(child: Container(child: Text("push notification"),))

  ),);
  }
  
}