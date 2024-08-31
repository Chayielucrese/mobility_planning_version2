import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';

class PushNotificationController extends AppController {
  @override
  void onInit() {
    super.onInit();

  }

  void notification() async {
    FirebaseMessaging.instance.getToken().then(
      (value) => {print("getToken: $value")},
    );
  }
}
