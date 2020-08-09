import 'package:flutter/material.dart';
import 'package:terawe_flutter_project/screens/login_screen.dart';
import 'package:terawe_flutter_project/screens/signup_screen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xFFf1f9ff),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 80.0, horizontal: 70.0),
                child: Text(
                  'Welcome to Datos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.blue,
                    fontFamily: 'Lora',
                  ),
                ),
              ),
              SizedBox(width: double.infinity),
//              Image(
//                image: AssetImage('Datos_Icon.png'),
//              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.blue,
                  disabledTextColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  splashColor: Colors.blueAccent,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.blue,
                  disabledTextColor: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  splashColor: Colors.blueAccent,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
