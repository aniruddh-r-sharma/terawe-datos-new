import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:terawe_flutter_project/screens/products_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 60.0,
              ),
              Center(
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Lora',
                    color: Colors.blue,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Lora',
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  'Please enter your credentials to proceed',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: kHintTextStyle,
                    prefixIcon: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: kHintTextStyle,
                    prefixIcon: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductsScreen();
                          },
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    'Or Sign in with:',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFBDE0FE),
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        print('facebook button');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFBDE0FE),
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        print('twitter button');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFBDE0FE),
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        print('google button');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
