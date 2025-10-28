import 'package:brownsofts/activities/api/api_calls.dart';
import 'package:brownsofts/screens/fragments/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _subjectController = TextEditingController();

  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = username.value;
    _emailController.text = useremail.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
  }

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
                        onPressed: () async {
                          // Fluttertoast.showToast(
                          //   msg:
                          //       "${_nameController.text}\n ${_emailController.text}\n ${_subjectController.text}\n ${_messageController.text}",
                          // );

                          var _result = await ApiCalls().sendFeedback(
                              name: _nameController.text,
                              email: _emailController.text,
                              subject: _subjectController.text,
                              Questions: _messageController.text,
                              belongs: "Mode Of Contact");
                          // Implement send logic

                          if (_result) {
                            Fluttertoast.showToast(
                                msg: "Feedback Send Succesfuly ✅");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Unable to send Your FeedBack ❌");
                          }
                          // _nameController.clear();
                          // _emailController.clear();
                          _subjectController.clear();
                          _messageController.clear();
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
