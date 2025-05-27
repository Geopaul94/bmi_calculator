import 'package:bmi_calculator/presentation/widgets/custom_text.dart';
import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double bmiResult;
  const ResultScreen({super.key, required this.bmiResult});

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final bmiCategory = getBMICategory(bmiResult);
    final bmiColor = getBMIColor(bmiResult);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16.0 : screenSize.width * 0.1,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your BMI Result',
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        bmiResult.toStringAsFixed(1),
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: bmiColor,
                          fontSize: 48,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bmiCategory,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: bmiColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _getBMIDescription(bmiCategory),
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Calculate Again',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getBMIDescription(String category) {
    switch (category) {
      case 'Underweight':
        return 'Your BMI indicates that you are underweight. Consider consulting with a healthcare provider about healthy ways to gain weight.';
      case 'Normal weight':
        return 'Congratulations! Your BMI is within the healthy range. Maintain a balanced diet and regular exercise to stay healthy.';
      case 'Overweight':
        return 'Your BMI indicates that you are overweight. Consider consulting with a healthcare provider about healthy ways to manage your weight.';
      case 'Obese':
        return 'Your BMI indicates obesity. It\'s recommended to consult with a healthcare provider about weight management strategies.';
      default:
        return '';
    }
  }
}
