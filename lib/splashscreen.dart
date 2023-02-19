// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:pigeoneye/home.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: const MyHomePage(),
      title: const Text(
        'Pigeon Eye👁',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
      ),
      image: Image.asset('image/remicon.png'),
      backgroundColor: Colors.green,
      photoSize: 60,
      loaderColor: const Color(0x00004242),
    );
  }
}
