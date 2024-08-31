


import 'package:flutter_application_1/Screens/Driver_dashboard/ViewWallet/wallet_view_ctrl.dart';

import 'package:get/get.dart';

class ViewWalletBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  ViewWalletController());
 }
}