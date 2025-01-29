import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomerEntryScreen extends StatefulWidget {
  CustomerEntryScreen(
      {super.key, required this.price_2, required this.product_name});
  int price_2;
  String product_name;
  @override
  State<CustomerEntryScreen> createState() => _CustomerEntryScreenState();
}

class _CustomerEntryScreenState extends State<CustomerEntryScreen> {
  var name_ = TextEditingController();
  var email_ = TextEditingController();
  String name_saved = "";
  String email_saved = "";
  String description_saved = "";

  final _formKey = GlobalKey<FormState>(); // Correctly typed GlobalKey
  String? onselectedvalue;
  get_ready_textField() async {
    var currentuser = await Remembrprefs.readCurrentUser();
    name_.text = currentuser!.name;
    email_.text = currentuser.user_email;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ready_textField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Service Checkout",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: 120, // Custom width
        height: 50, // Custom height
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Submit action here

              Navigator.of(context).push(MaterialPageRoute(builder: (cvb) {
                return PaypalCheckoutView(
                  sandboxMode: false,
                  clientId:
                      "AXnnwhAS1KVBJv9q9FO0B6OH067dPUBz8Z03qy0uWDvn-VeAoM8dLe03MPjSjxZRNdTUKKQaCxwjEj56",
                  secretKey:
                      "EN3xk2NB23hty3iPs87A_0sfcteGi2XlSjlE6sTMJUHKjG3ZGubyUhbnDTwDq899EV_lM5KKjjdwNWJ2",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                    Fluttertoast.showToast(msg: "Payment Succes");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Payment Succes",
                    )));
                  },
                  onError: (error) {
                    print("onError: $error");
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Payment Errorb : $error");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Payment Error ",
                    )));
                  },
                  onCancel: () {
                    Fluttertoast.showToast(msg: "Payment Cancellerd");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Payment Cancelled",
                    )));
                  },
                  transactions: [
                    {
                      "amount": {
                        "total": '${widget.price_2}',
                        "currency": "USD",
                        "details": {
                          "subtotal": '${widget.price_2}',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      "payment_options": {
                        "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
                      },
                      "item_list": {
                        "items": [
                          {
                            "name": "${widget.product_name}",
                            "quantity": 1,
                            "price": '${widget.price_2}', // 5 items × $14 = $70
                            "currency": "USD"
                          }
                        ],
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                );
              }));
            }
          },
          label: const Row(
            //    mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_right_rounded,
                size: 28,
              ),
            ],
          ),
          // backgroundColor: Colors.orange, // Optional: Add background color
        ),
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Title

                //   const SizedBox(height: 20),
                // Form
                Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Form Section
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name Field

                            Text(
                              "Name*",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: name_,
                              onSaved: (newValue) {
                                name_saved = newValue!;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter your name",
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Email Field

                            Text(
                              "Email Address*",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: email_,
                              onSaved: (newValue) {
                                email_saved = newValue!;
                              },
                              decoration: InputDecoration(
//hintText: "Enter your email",
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required.";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Message Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Message*",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  onSaved: (newValue) {
                                    description_saved = newValue!;
                                  },
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    hintText: "Enter your message",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "The message field is required.";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField(
                                value: 0,
                                onSaved: (newValue) {},
                                items: const [
                                  DropdownMenuItem(
                                      value: 0,
                                      child: Text("Choose payment method")),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Image(
                                            height: 15,
                                            image: AssetImage(
                                                "assets/paypal.png")),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Paypal")
                                      ],
                                    ),
                                  )
                                ],
                                validator: (value) {
                                  if (value != 1) {
                                    return "Select any Payment Method";
                                  } else
                                    return null;
                                },
                                onChanged: (vb) {
                                  print(vb);
                                }),

                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Submit action here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form submitted')),
                                  );
                                }
                              },
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32), // Spacing
                      // Right Section: Placeholder for Package Card
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required.";
            }
            return null;
          },
        ),
      ],
    );
  }
}
