import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ClassifyScreen extends StatefulWidget {
  final String imageName;

  ClassifyScreen({this.imageName});

  @override
  _ClassifyScreenState createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends State<ClassifyScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String path;
  var api_response;

  final _firestore = Firestore.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getPictures() async {
    final pictures = await _firestore.collection('pictures').getDocuments();
    for (var picture in pictures.documents) {
      if (picture.data['user'] == loggedInUser.email &&
          picture.data['product_title'] == widget.imageName) {
        return picture.data['img_path'].toString();
      } else
        () {
          return null;
        };
    }
  }

  Future getPicturePath() async {
    try {
      final picturePath = await getPictures();
      if (picturePath != null) {
        path = picturePath;
        print(path);
      }
    } catch (e) {
      print(e);
    }
  }

  void Upload(File file) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    var response = await dio.post(
        "https://smartretailflask.azurewebsites.net/rest/classify",
        data: data);

    print(response);
    api_response = json.decode(json.encode(response.data));
    print(api_response['class_output']);
    _showDialog(api_response['class_output'].toString());
  }

  void _showDialog(String product) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Classification Complete"),
          content: new Text(product),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getCurrentUser();
    getPicturePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'Classify',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: RawMaterialButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Classify your image",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          fillColor: Colors.blue,
          onPressed: () {
            print('Classification in progress');
            Upload(File(path));
            print(api_response);
          },
        ),
      ),
    );
  }
}
