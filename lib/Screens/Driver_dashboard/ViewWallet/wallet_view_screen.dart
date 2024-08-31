import 'package:flutter/material.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/ViewWallet/wallet_view_ctrl.dart';
import 'package:get/get.dart';

class WalletViewPage extends StatelessWidget {
  const WalletViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<ViewWalletController>().myWallet();
        return true;
      },
      child: GetBuilder<ViewWalletController>(
        builder: (controller) => DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false, // Remove the back button
              title: Text(
                "My Wallet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                if (controller.mywallet !=
                    null) // Show Add button only if there are no vehicles
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      Get.toNamed(AppRoutes.userwallet)?.then((_) {
                        controller
                            .myWallet(); // Refresh the list after returning
                      });
                    },
                  ),
              ],
              backgroundColor: Colors.pink, // Set background color if needed
            ),
            body: TabBarView(
              children: [
                controller.mywallet != null &&
                        controller.passwordController.text != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'Assets/empty_wallet.png',
                              width: 300,
                              height: 200,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'current Balance: ${controller.currentBalance}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Assets/city_driver.png',
                            width: 300,
                            height: 200,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'current Balance:${controller.currentBalance} FCFA',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
