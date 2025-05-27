import 'package:bmi_calculator/presentation/screens/result_screen.dart';
import 'package:bmi_calculator/presentation/widgets/custom_button.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';
import 'package:bmi_calculator/presentation/widgets/custom_text.dart';
import 'package:bmi_calculator/presentation/widgets/custome_gender_container.dart';
import 'package:bmi_calculator/utilities/constants/constants.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final viewModel = Provider.of<BMIViewModel>(context);
    final sliderProvider = Provider.of<HeightWeightSlider>(context);
    final theme = Theme.of(context);

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
                Text(
                  'BMI Calculator',
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Calculate your Body Mass Index',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                Text(
                  'Select Gender',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.updateGender('Male'),
                        child: CustomGenderContainer(
                          text: "Male",
                          icon: const Icon(Icons.male),
                          isSelected: viewModel.bmiModel.gender == 'Male',
                        ),
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.updateGender('Female'),
                        child: CustomGenderContainer(
                          text: "Female",
                          icon: const Icon(Icons.female),
                          isSelected: viewModel.bmiModel.gender == 'Female',
                        ),
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.updateGender('Others'),
                        child: CustomGenderContainer(
                          text: "Others",
                          icon: null,
                          imageOthers: Image.asset(
                            'assets/images/gender-others.png',
                            width: 32,
                            height: 32,
                            color: white,
                          ),
                          isSelected: viewModel.bmiModel.gender == 'Others',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Height',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${sliderProvider.height.toStringAsFixed(1)} cm / "
                        "${sliderProvider.heightInFeet.toStringAsFixed(2)} ft",
                        style: theme.textTheme.bodyLarge,
                      ),
                      Slider(
                        value: sliderProvider.height,
                        min: 50,
                        max: 250,
                        divisions: 200,
                        label: "${sliderProvider.height.toStringAsFixed(1)} cm",
                        onChanged: (value) {
                          sliderProvider.updateHeight(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${sliderProvider.weight.toStringAsFixed(1)} kg / "
                        "${sliderProvider.weightInPounds.toStringAsFixed(1)} lbs",
                        style: theme.textTheme.bodyLarge,
                      ),
                      Slider(
                        value: sliderProvider.weight,
                        min: 30,
                        max: 180,
                        divisions: 150,
                        label: "${sliderProvider.weight.toStringAsFixed(1)} kg",
                        onChanged: (value) {
                          sliderProvider.updateWeight(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: CustomButton(sliderProvider: sliderProvider),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
