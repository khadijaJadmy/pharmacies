import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File imageFile;

  Future<void> openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a Choice'),
            actions: <Widget>[
              FlatButton(
                child: Text('Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                },
              ),
              FlatButton(
                child: Text('Camera'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 400,
                      maxHeight: 400);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.grey,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'camera',
              child: Icon(Icons.camera_alt),
              onPressed: () {
                openDialog(context);
              }),
        ],
      ),
    );
  }
}
