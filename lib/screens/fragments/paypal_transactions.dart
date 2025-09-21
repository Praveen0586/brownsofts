import 'dart:async';

import 'package:brownsofts/activities/models/Store_to_Database.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/fragments/send_to_server.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaypalCheckout extends StatelessWidget {
  const PaypalCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    var _sandboxClientId = dotenv.env['SANDBOX_CLIENDID'];
    var _sandboxSecretKey = dotenv.env['SANDBOX_SECRETKEY'];
    var _selectedProductname = selectedserviceName.value;
    var _selectedProductprice = selectedservicePrice.value;
    var _userTypedDescription = userdescription.value;
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: _sandboxClientId,
      secretKey: _sandboxSecretKey,
      transactions: [
        {
          "amount": {
            "total": '${_selectedProductprice}',
            "currency": "USD",
            "details": {
              //   "subtotal": '100',
              // "shipping": '0',
              // "shipping_discount": 0
            }
          },
          "description": "${_userTypedDescription.toString()}",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {
                "name": "${_selectedProductname.toString()}",
                "quantity": 1,
                "price": '${_selectedProductprice}',
                "currency": "USD"
              },
              // {
              //   "name": "Pineapple",
              //   "quantity": 5,
              //   "price": '12',
              //   "currency": "USD"
              // }
            ],

            // Optional
            //   "shipping_address": {
            //     "recipient_name": "Tharwat samy",
            //     "line1": "tharwat",
            //     "line2": "",
            //     "city": "tharwat",
            //     "country_code": "EG",
            //     "postal_code": "25025",
            //     "phone": "+00000000",
            //     "state": "ALex"
            //  },
          }
        }
      ],
      note: "Brownsofts Services ",
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
      onSuccess: (Map params) async {
        Future.delayed(Duration(seconds: 2), () {
          Center(child: LinearProgressIndicator());
          //  Navigator.pop(context);
        });

        await SendToServer().sendtoServer(params);
        paymentPaypalId.value = params['data']['id'];
        paymentPaypalEmail.value =
            params['data']['payer']['payer_info']['email'];
        print("paymentPaypalId: ${paymentPaypalId.value}");
        print("paymentPaypalEmail: ${paymentPaypalEmail.value}");
        //  selectedServiceId.
        purchasedServices.value.add(selectedServiceId.value);

        print(purchasedServices.value);

        await SendToServer().sendEmailData(
          name: username.value.toString(),
          mail: useremail.value.toString(),
          contact: "Skype Details",
          userMessage: userdescription.value.toString(),
          service: selectedserviceName.value.toString(),
          packageName: selectedPricePackage.value.toString(),
          price: "\$${selectedservicePrice.value.toString()}",
          date: DateTime.now().toUtc().toString(),
          payment: "Paid via Credit Card",
          paypalpaymentemail: paymentPaypalEmail.value,
          paypalpaymentid: paymentPaypalId.value,
        );

        Get.off(PaymentSuccesScreen());
        // print("onSuccess: $params");

        // SendToServer().sendtoServer(params);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => InvoiceScreen(params: params),
        //   ),
        // );
      },
      onError: (error) {
        //    log("onError: $error");
        print("OnError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('cancelled:');
        Navigator.pop(context);
      },
    );
  }
}

class PaymentSuccesScreen extends StatefulWidget {
  const PaymentSuccesScreen({super.key});

  @override
  State<PaymentSuccesScreen> createState() => _PaymentSuccesScreenState();
}

class _PaymentSuccesScreenState extends State<PaymentSuccesScreen> {
  int _start = 3;
  Timer? _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Set a 3 second timer then navigate to home page
    startTimer();

    Timer(Duration(seconds: 3), () {
      Get.off(const ReciptScreen());
      // or Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child:
                  Lottie.asset("assets/lotties/addtocart.json", onLoaded: (p0) {
            print(p0);
          }, reverse: true, repeat: true, height: 250, width: 250)),
          SizedBox(height: 20),
          Text(
            'Payment Successful!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Text(
          //   'Thank you for your purchase.',
          //   style: TextStyle(fontSize: 16),
          // ),
          // SizedBox(height: 30),
          Text(
            'Redirecting in $_start seconds...',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class ReciptScreen extends StatelessWidget {
  const ReciptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}

RxString paymentPaypalId = ''.obs;
RxString paymentPaypalEmail = ''.obs;
