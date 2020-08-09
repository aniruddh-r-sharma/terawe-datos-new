import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/screens/product_input.dart';
import 'package:terawe_flutter_project/widgets/products_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
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

  void getPictures() async {
    final pictures = await _firestore.collection('pictures').getDocuments();
    for (var picture in pictures.documents) {
      print(picture.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'PRODUCT',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.subject,
            color: Colors.blue,
            size: 38.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              getPictures();
            },
            icon: Icon(
              Icons.search,
              color: Colors.blue,
              size: 38.0,
            ),
          ),
        ],
      ),
      body: ProductsList(),
      // bottom button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductInput();
              },
            ),
          );
        },
        shape: CircleBorder(
            side: BorderSide(
          color: Colors.blue,
          width: 2.0,
        )),
        backgroundColor: Colors.white,
        elevation: 0.0,
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
