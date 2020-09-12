import 'package:flutter/material.dart';
import 'package:http_flutter/app/apiservice/apiservice.dart';
import 'package:http_flutter/app/ui/home.dart';
import 'package:connectivity/connectivity.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  ApiServices apiServices;
  Connectivity subscription = Connectivity();
  //StreamSubscription<ConnectivityResult> _con;

  bool connections_ = false;

  void checkConnection() {
    subscription.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        connections_ = false;
      } else {
        connections_ = true;
      }
    });
  }

  @override
  void initState() {
    apiServices = ApiServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Password terlalu pendek';
                            }
                            return null;
                          },
                        ),
                        RaisedButton(
                            child: Text('Login'),
                            onPressed: () {
                              checkConnection();
                              if (connections_) {
                                if (_formKey.currentState.validate()) {
                                  apiServices.login({
                                    'username': username.text,
                                    'password': password.text
                                  }).then((value) {
                                    if (value.accessToken != null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Home(
                                                    token: value.accessToken,
                                                  )));
                                    } else {
                                      _scaffoldState.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'username or password wrong')));
                                    }
                                  });
                                }
                              } else {
                                _scaffoldState.currentState.showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to connect to internet')));
                              }
                            })
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
