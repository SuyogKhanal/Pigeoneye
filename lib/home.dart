// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_field

import 'dart:io';
import 'package:pigeoneye/developerscreen.dart';
import 'package:tflite/tflite.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagepicker = ImagePicker();
  File? _image;
  List? _output;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.8,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    try {
      setState(() {
        _output = output!;
        _loading = false;
      });
    } on RangeError {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Image"),
            content:
                Text("Please select an image of a banana, orange, or apple."),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "image/model.tflite",
      labels: "image/label.txt",
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getImagefromcamera() async {
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image!);
  }

  Future getImagefromGallery() async {
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(newMethod(image));
    });
    detectImage(_image!);
  }

  String newMethod(XFile image) => image.path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text("Pigeon Eye👁"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeveloperScreen()),
                  );
                },
                icon: Icon(Icons.info_rounded))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Fruits Freshness Detection",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/bgimg.gif'),
                        fit: BoxFit.cover)),
                width: MediaQuery.of(context).size.width,
                height: 600.0,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: _image == null
                            ? Text(
                                "No Image is picked",
                                style: TextStyle(
                                    height: 9,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent),
                              )
                            : Image.file(File(_image!.path)),
                      ),
                      _output != null
                          ? Container(
                              color: Colors
                                  .black, // set background color of container
                              child: Text(
                                '${_output?[0]['label']}',
                                style: TextStyle(
                                    height: 5,
                                    color: Colors.yellowAccent,
                                    fontSize: 18),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.deepPurpleAccent,
                  heroTag: null,
                  onPressed: getImagefromcamera,
                  tooltip: "Click new image from camera",
                  child: Icon(Icons.camera_alt_rounded),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurpleAccent,
                  heroTag: null,
                  onPressed: getImagefromGallery,
                  tooltip: "Pick Image from Gallery",
                  child: Icon(Icons.photo),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
