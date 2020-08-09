import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/screens/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:terawe_flutter_project/models/product_data.dart';
import 'package:terawe_flutter_project/screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductData(),
      child: MaterialApp(
        home: IntroScreen(),
      ),
    );
  }
}
