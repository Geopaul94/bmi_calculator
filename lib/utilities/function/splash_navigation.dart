import 'package:bmi/main.dart';
import 'package:bmi/presentation/screeens/home_screen.dart';
import 'package:flutter/material.dart';
Future<void> autonavigation(BuildContext context) async {
  Future.delayed(Duration(seconds: 2), () {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage(title: 'hello'); // Corrected title text
    }));
  });
}
