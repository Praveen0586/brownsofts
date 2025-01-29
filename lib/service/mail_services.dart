import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class MailService {
  MailService() {
    print("Mainservice Started");
    dotenv.load(fileName: ".env");
  }

  final userName = dotenv.env["OUREMAIL"];
  final password = dotenv.env["PASSWORD"];

  late SmtpServer smtpServer =
      gmail(dotenv.env["OUREMAIL"]!, dotenv.env["PASSWORD"]!);

  send_mail(
      String name,
      String mail,
      String contact,
      String userMessage,
      String service,
      String package,
      String price,
      String date,
      String payment) async {
    final Message message = new Message()
      ..from = Address("Brownsofts Mobile")
      ..recipients.add(dotenv.env["RECEPTIONIST"])
      ..subject = 'Service Purchase from Brownsofts Mobile Application'
      ..html = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        body {
            background-color: #1e1e1e;
            color: white;
            font-family: Arial, sans-serif;
            padding: 20px;
            line-height: 1.6;
        }

        h1 {
            text-align: center;
            color: white;
            text-decoration: underline;
        }

        .section {
            margin-bottom: 30px;
        }

        .section h2 {
            color: black;
            
            
        }

        .details {
            display: grid;
            grid-template-columns: 150px auto;
            row-gap: 10px;
        }

        .details span {
            display: block;
        }

        a {
            color: #00bfff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="section"><br><br>
        <h3>User Details:</h3>
        <div class="details">
            <span><strong>Name</strong></span>
            <span>$name</span>

            <span><strong>Email</strong></span>
            <span><a href="mailto:$mail">$mail</a></span>

            <span><strong>Contact</strong></span>
            <span>$contact</span>

            <span><strong>User Message</strong></span>
            <span>$userMessage</span>
        </div>
    </div>

    <div class="section"><br><br>
        <h3>Purchase Details:</h3>
        <div class="details">
            <span><strong>Service</strong></span>
            <span>$service</span>

            <span><strong>Selected Package</strong></span>
            <span>$package</span>

            <span><strong>Price</strong></span>
            <span>$price</span>

            <span><strong>Date</strong></span>
            <span>$date<small>(Date of Purchase)</small></span>

            <span><strong>Payment</strong></span>
            <span>$payment</span>
        </div>
    </div>
</body>
</html>
""";

    try {
      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger(
        child: SnackBar(content: Text("Succes")),
      );
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
