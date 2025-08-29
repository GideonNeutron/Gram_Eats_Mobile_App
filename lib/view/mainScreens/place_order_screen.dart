import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gram_eats/global/global_instances.dart';
import 'package:gram_eats/global/global_vars.dart';
import 'package:gram_eats/paymentSystem/payment_config.dart';
import 'package:gram_eats/view/mainScreens/home_screen.dart';
import 'package:pay/pay.dart';

class PlaceOrderScreen extends StatefulWidget
{
  String? addressID;
  double? totalAmount;
  String? sellerUID;

  PlaceOrderScreen({super.key, this.addressID, this.totalAmount, this.sellerUID});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset("assets/images/pay_now.png"),

          const SizedBox(height: 30,),

          paymentResult != ""
          ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
              commonViewModel.showSnackBar("Congratulations, order has been placed successfully", context);
            },
            child: const Text(
              "Continue"
            ),
          )
          : Platform.isIOS
          ? ApplePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
              paymentItems: [
                PaymentItem(
                    amount: widget.totalAmount.toString(),
                    label: "Total",
                    status: PaymentItemStatus.final_price,
                ),
              ],
              style: ApplePayButtonStyle.black,
              width: double.infinity,
              height: 50,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15),
              onPaymentResult: (result)
              {
                print("Payment Result = $result");

                setState(() {
                  paymentResult = result.toString();
                });

                //save order details to Database
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(color: Colors.green,),
              ),
          )

          : GooglePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: [
              PaymentItem(
                amount: widget.totalAmount.toString(),
                label: "Total",
                status: PaymentItemStatus.final_price,
              ),
            ],
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15),
            onPaymentResult: (result)
            {
              print("Payment Result = $result");

              setState(() {
                paymentResult = result.toString();
              });

              //save order details to Database
            },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(color: Colors.green,),
            ),
          ),
        ],
      ),
    );
  }
}
