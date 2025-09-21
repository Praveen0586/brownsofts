import 'package:brownsofts/activities/models/remember_user.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:brownsofts/screens/fragments/paypal_transactions.dart';
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
    // var currentuser = await Remembrprefs.readCurrentUser();
    // name_.text = currentuser!.name;

    // email_.text = currentuser.user_email;
    name_.text = username.value;
    email_.text = useremail.value;
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
                return PaypalCheckout();
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
                                    userdescription.value = newValue;
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
                                  selectedserviceName.value =
                                      widget.product_name;
                                  selectedservicePrice.value = widget.price_2;
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
