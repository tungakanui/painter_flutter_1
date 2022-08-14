import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_painter.dart';

String car =
    "https://vcdn-vnexpress.vnecdn.net/2020/07/09/Toyota-Corolla-Cross-1-1745-1594266849.jpg";

String trans =
    "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png";

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Painter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImagePainterExample(),
    );
  }
}

class ImagePainterExample extends StatefulWidget {
  @override
  _ImagePainterExampleState createState() => _ImagePainterExampleState();
}

class _ImagePainterExampleState extends State<ImagePainterExample> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();

  Uint8List bytes = Uint8List.fromList([]);

  void saveImage() async {
    final image = await _imageKey.currentState.exportImage();
    setState(() {
      bytes = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      key: _key,
      appBar: AppBar(
        title: const Text("Image Painter Example"),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: Image.memory(bytes),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(trans), fit: BoxFit.fill)),
              child: ImagePainter.network(
                trans,
                key: _imageKey,
                backgroundUrl: car,
                scalable: true,
                height: 1000,
                width: 720,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
