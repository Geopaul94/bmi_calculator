import 'package:bmi_calculator/presentation/widgets/custom_text.dart';
import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
    var bmiResult;
   ResultScreen({super.key, required this.bmiResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Center(
                  child: CustomText(
                    text: "Your BMI Result",
                    fontSize: 24,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Center(
                  child:  CustomText(
                    text:bmiResult.toString(),
                    fontSize: 24,
                    color: white,
                    fontWeight: FontWeight.bold,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
