import 'dart:convert';

import 'package:brownsofts/activities/api/apis.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SendToServer {
  // static String test = "http://localhost:8000/payments/payment_granted";
  // static String live =
  // "https://brownsofts-new-js-server.onrender.com/payments/payment_granted";

  // bool islive = true;
  Future<void> sendtoServer(Map<dynamic, dynamic> paypalData) async {
    //Uri url = islive ? Uri.parse(live) : Uri.parse(test);

    Uri url = Uri.parse(BrownAPI.storePurchase);
    http.post(url,
        body: jsonEncode({
          "paypalData": paypalData,
          "userID": userID.value,
          "userEmail": useremail.value,
          "userName": username.value,
        }),
        headers: {
          "Content-Type": "application/json"
        }).then((http.Response response) {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Payment Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorsUsed.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Data sent successfully");
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed to send data. Status code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorsUsed.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Failed to send data. Status code: ${response.statusCode}");
      }
    }).catchError((error) {
      print("Error sending data: $error");
    });
  }

  Future<void> sendEmailData({
    required String name,
    required String mail,
    required String contact,
    required String userMessage,
    required String service,
    required String packageName,
    required String price,
    required String date,
    required String payment,
    required String paypalpaymentemail,
    required String paypalpaymentid,
  }) async {
    final url = Uri.parse(BrownAPI.sendEmail); // Replace with your API URL

    final body = {
      "name": name,
      "mail": mail,
      "contact": contact,
      "userMessage": userMessage,
      "service": service,
      "package": packageName,
      "price": price,
      "date": date,
      "payment": payment,
      "paypalpaymentemail": paypalpaymentemail,
      "paypalpaymentid": paypalpaymentid,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        Fluttertoast.showToast(
            msg: "Email sent successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorsUsed.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
        // Use responseData as needed
      } else {
        print('Request failed with status: ${response.statusCode}');
        Fluttertoast.showToast(
            msg: "Failed to send email. Status code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: ColorsUsed.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
