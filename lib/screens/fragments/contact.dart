import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Get in touch with our team for assistance'),
            const SizedBox(height: 16),

            // Email Support Card
            Card(
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.orange),
                title: const Text('Email Support'),
                subtitle: const Text('We\'ll respond within 24 hours'),
                trailing: GestureDetector(
                  onTap: () async {
                    final Uri mailUri = Uri(
                      scheme: 'mailto',
                      path: 'support@brownsofts.com',
                    );
                    if (await canLaunchUrl(mailUri)) {
                      await launchUrl(mailUri);
                    } else {
                      // Optionally show error
                    }
                  },
                  child: const Text(
                    'support@brownsofts.com',
                    style: TextStyle(
                      color: Colors.orange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Contact Form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Send us a message',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email address',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        hintText: 'What\'s this about?',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        hintText: 'Describe your question or issue...',
                      ),
                      maxLines: 4,
                      maxLength: 500,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg:
                                "${_nameController.text}\n ${_emailController.text}\n ${_subjectController.text}\n ${_messageController.text}",
                          );

                          // Implement send logic
                        },
                        label: const Text('Send Message'),
                        icon: const Icon(Icons.send),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
