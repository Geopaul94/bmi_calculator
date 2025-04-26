import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BMIViewModel(),
      child: MaterialApp(
        title: 'BMI Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
