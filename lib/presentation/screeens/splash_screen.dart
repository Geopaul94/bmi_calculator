import 'package:bmi/utilities/function/splash_navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    autonavigation(context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Center(
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}
