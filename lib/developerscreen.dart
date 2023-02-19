import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://yt3.ggpht.com/TGyXqkaHVjSg0Yr_49VgLRGWM15gYoVisIXwA4TLyU03o1lcMG1IYv1w4lk-29_4onQhI7K5Wdg=s600-c-k-c0x00ffffff-no-rj-rp-mo';
    String linkedInUrl = 'https://www.linkedin.com/in/suyog-khanal-354331173/';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 16),
            const Text(
              'Suyog Khanal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '8848suyog@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text('''
              Model: Xception
              
              Overall Test Accuracy: 98.04%''',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                if (!await canLaunch(linkedInUrl)) {
                  await launch(linkedInUrl);
                } else {
                  throw 'Could not launch $linkedInUrl';
                }
              },
              child: const Text(
                'Visit my LinkedIn profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
