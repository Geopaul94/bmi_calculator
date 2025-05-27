import 'package:bmi_calculator/presentation/screens/result_screen.dart';
import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.sliderProvider,
  });

  final HeightWeightSlider sliderProvider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      width: isSmallScreen ? double.infinity : screenSize.width * 0.4,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final result = sliderProvider.calculateBMI();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  bmiResult: result,
                ),
              ),
            );
          },
          child: Center(
            child: Text(
              "Calculate BMI",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
