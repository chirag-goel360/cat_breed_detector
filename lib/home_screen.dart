import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<File> imageFile;
  File _image;
  String result = '';
  ImagePicker imagePicker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
              ),
              child: Stack(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: selectPhoto,
                      onLongPress: capturePhoto,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 30,
                          right: 35,
                          left: 18,
                        ),
                        child: _image != null
                            ? Image.file(
                                _image,
                                height: 160,
                                width: 400,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 140,
                                height: 190,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                '$result',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectPhoto() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );
    _image = File(
      pickedFile.path,
    );
    setState(() {
      classifyImage();
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  capturePhoto() async {
    PickedFile pickedFile = await imagePicker.getImage(
      source: ImageSource.camera,
    );
    _image = File(
      pickedFile.path,
    );
    setState(() {
      classifyImage();
    });
  }

  loadDataModelFiles() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  classifyImage() async {
    var recognitions = await Tflite.runModelOnImage(
      path: _image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.1,
      asynch: true,
    );
    print(recognitions.length.toString());
    setState(() {
      result = "";
    });
    recognitions.forEach((element) {
      setState(() {
        result += element["label"];
      });
    });
  }
}
