import 'package:flutter/material.dart';
//import 'package:http_flutter/app/ui/home.dart';
import 'package:http_flutter/app/ui/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
