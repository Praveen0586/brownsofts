import 'package:brownsofts/screens/fragments/final_purchase_page.dart';
import 'package:flutter/material.dart';

class CustomerEntryScreen extends StatefulWidget {
  const CustomerEntryScreen({super.key});

  @override
  State<CustomerEntryScreen> createState() => _CustomerEntryScreenState();
}

class _CustomerEntryScreenState extends State<CustomerEntryScreen> {
  final _formKey = GlobalKey<FormState>(); // Correctly typed GlobalKey
  String? onselectedvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 120, // Custom width
        height: 50, // Custom height
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Submit action here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form submitted')),
              );
              Navigator.of(context).push(MaterialPageRoute(builder: (cvb) {
                return FinalPurchasePage();
              }));
            }
          },
          label: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          margin: EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Title
                  Center(
                    child: const Text(
                      "Service Checkout",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                              _buildInputField(
                                  label: "Name*", hint: "Enter your name"),
                              const SizedBox(height: 16),
                              // Email Field
                              _buildInputField(
                                  label: "Email Address*",
                                  hint: "Enter your email"),
                              const SizedBox(height: 16),
                              // Message Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Message*",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
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
                                  items: [
                                    DropdownMenuItem(
                                        value: 0,
                                        child: Text("Choose payment method")),
                                    DropdownMenuItem(
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
                                      value: 1,
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
