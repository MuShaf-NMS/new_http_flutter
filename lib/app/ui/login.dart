import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http_flutter/app/apiservice/apiservice.dart';
import 'package:http_flutter/app/ui/home.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  ApiServices apiServices;
  Connectivity subscription = Connectivity();
  StreamSubscription<ConnectivityResult> _con;

  bool connections_ = false;

  @override
  void initState() {
    _con =
        subscription.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        connections_ = false;
      } else {
        connections_ = true;
      }
    });
    apiServices = ApiServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: ListView(
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: 200,
                  height: 100,
                ),
                TextField(
                  controller: username,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (connections_) {
                        apiServices.login({
                          'username': username.text,
                          'password': password.text
                        }).then((value) {
                          if (value.accessToken != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Home(
                                          token: value.accessToken,
                                        )));
                          }
                        });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
