import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terawe_flutter_project/models/product_data.dart';
import 'package:provider/provider.dart';
import 'package:terawe_flutter_project/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductInput extends StatefulWidget {
  @override
  _ProductInputState createState() => _ProductInputState();
}

class _ProductInputState extends State<ProductInput> {
  File imageFile;
  DateTime selectedDate = DateTime.now();
  String filePath;
  final picker = ImagePicker();
  final _firestore = Firestore.instance;

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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

  _openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        imageFile = File(pickedFile.path);
        filePath = imageFile.path;
      },
    );
  }

  _openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(
      () {
        imageFile = File(pickedFile.path);
        filePath = imageFile.path;
        print(loggedInUser);
      },
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose a Picture'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    String selectedDate = 'Tap to select Date';
    String newProductName;
    String newUPN;
    String newAisle;
    String newShelf;

    final bgColour = Color(0xFFBDE0FE);
    return Scaffold(
      backgroundColor: Color(0xFFF1F8FF),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'Add New Product',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFFF1F8FF),
        leading: IconButton(
          icon: Icon(
            Icons.subject,
            color: Colors.blue,
            size: 38.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
              size: 38.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // add image
            Flexible(
              fit: FlexFit.loose,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                elevation: 0.0,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: bgColour,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // text field input
            Flexible(
              fit: FlexFit.loose,
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (newText) {
                          newProductName = newText;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: bgColour),
                          ),
                          labelText: 'Product Name',
                          labelStyle: kHintTextStyle,
                          prefixIcon: Icon(
                            Icons.star,
                            color: bgColour,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        child: Text(
                          selectedDate,
                          style: kHintTextStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: bgColour),
                          ),
                          labelText: 'UPN',
                          labelStyle: kHintTextStyle,
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: bgColour,
                          ),
                        ),
                        onChanged: (newText) {
                          newUPN = newText;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (newText) {
                                newAisle = newText;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: bgColour),
                                ),
                                labelText: 'Aisle',
                                labelStyle: kHintTextStyle,
                                prefixIcon: Icon(
                                  Icons.local_offer,
                                  color: bgColour,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (newText) {
                                newShelf = newText;
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: bgColour),
                                ),
                                labelText: 'Shelf',
                                labelStyle: kHintTextStyle,
                                focusColor: bgColour,
                                prefixIcon: Icon(
                                  Icons.local_offer,
                                  color: bgColour,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // confirm addition
            Flexible(
              fit: FlexFit.loose,
              child: Card(
                elevation: 0.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: bgColour,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _firestore.collection('pictures').add(
                            {
                              'img_path': filePath,
                              'user': loggedInUser.email,
                              'product_title': newProductName,
                            },
                          );
                          Provider.of<ProductData>(context).addProduct(
                              newUPN, newProductName, newAisle, newShelf);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
