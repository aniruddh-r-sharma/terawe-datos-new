import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';

class ImageScreen extends StatefulWidget {
  final String imageName;

  ImageScreen({this.imageName});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String path;

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

  @override
  void initState() {
    getCurrentUser();
    getPicturePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Image> image) {
        if (path != null) {
          return Image.file(File(path)); // image is ready
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
              color: Colors.white,
            ),
          ); // placeholder
        }
      },
    );
  }
}
