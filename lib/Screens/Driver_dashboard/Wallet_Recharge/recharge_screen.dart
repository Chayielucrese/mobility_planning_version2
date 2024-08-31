import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Routes/app_routes.dart';

class WalletRechargePage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        } else {
          Get.toNamed(AppRoutes.viewwallet);
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recharge Wallet',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Image
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'Assets/Wallet-pana.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Recharge Wallet Form

              SizedBox(height: 20),
              appTextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  labelText: "Phone Number +237",
                  icon: Icons.phone),

              SizedBox(height: 20),
              appTextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  labelText: "Amount to Recharge",
                  icon: Icons.account_balance),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
             Get.toNamed(AppRoutes.login);
                  String amount = amountController.text;
                  if (amount.isNotEmpty) {
                    // Implement the recharge logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Recharging wallet with \$${amount}')),
                    );
                  } else {
                    // Handle empty amount input
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please enter an amount to recharge')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Recharge',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
