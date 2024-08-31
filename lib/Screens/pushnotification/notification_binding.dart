import 'package:flutter_application_1/Screens/SignUp/signup_controller.dart';
import 'package:flutter_application_1/Screens/pushnotification/notification_ctrl.dart';
import 'package:get/get.dart';

class PushNotificationBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  PushNotificationController());
 }
}