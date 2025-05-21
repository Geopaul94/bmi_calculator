import 'package:bmi_calculator/presentation/widgets/custom_text.dart';
import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double bmiResult;
  const ResultScreen({super.key, required this.bmiResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: "Your BMI Result",
                  fontSize: 24,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: bmiResult.toStringAsFixed(1), // optional: limit decimals
                  fontSize: 48,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
