import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:terawe_flutter_project/screens/products_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  'Sign Up',
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
                  'Register',
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
                  style: TextStyle(
                    color: Colors.blue,
                  ),
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
                  style: TextStyle(
                    color: Colors.blue,
                  ),
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
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
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
                    'Or Sign up with:',
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
                        print('facebook button signup');
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
                        print('twitter button signup');
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
                        print('google button signup');
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
