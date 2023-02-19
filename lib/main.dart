import 'package:flutter/material.dart';
import 'package:pigeoneye/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Pigeon Lens',
      home: const MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
