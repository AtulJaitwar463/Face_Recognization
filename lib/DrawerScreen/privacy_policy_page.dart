import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Face Deblurring and Detection App',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Your privacy is important to us. It is our policy to respect your privacy regarding any information we may collect while operating our application.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Information We Collect:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- We may collect personal information that you provide voluntarily, such as your name and email address when you contact us for support or feedback.',
            ),
            SizedBox(height: 8.0),
            Text(
              '- We may collect non-personal information automatically, such as device information, IP addresses, and usage data for analytics purposes.',
            ),
            SizedBox(height: 16.0),
            Text(
              'How We Use Information:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Personal information is used to respond to your inquiries, provide support, and improve our services.',
            ),
            SizedBox(height: 8.0),
            Text(
              '- Non-personal information is used for analytics to understand user behavior and improve our application.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Security:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- We take reasonable measures to protect your personal information from unauthorized access or disclosure.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Changes to This Privacy Policy:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- We may update our Privacy Policy from time to time. Any changes will be reflected on this page.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- If you have any questions about our Privacy Policy, please contact us at support@example.com.',
            ),
          ],
        ),
      ),
    );
  }
}

