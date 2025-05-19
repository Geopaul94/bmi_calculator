import 'package:bmi_calculator/presentation/screens/result_screen.dart';
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

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16.0 : screenSize.width * 0.1,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => viewModel.updateGender('Male'),
                                child: CustomeGenderContainer(
                                  text: "Male",
                                  icon: const Icon(Icons.male),
                                  isSelected:
                                      viewModel.bmiModel.gender == 'Male',
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => viewModel.updateGender('Female'),
                                child: CustomeGenderContainer(
                                  text: "Female",
                                  icon: const Icon(Icons.female),
                                  isSelected:
                                      viewModel.bmiModel.gender == 'Female',
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => viewModel.updateGender('Others'),
                                child: CustomeGenderContainer(
                                  text: "Others",
                                  icon: null,
                                  imageOthers: Image.asset(
                                      'assets/images/gender-others.png',
                                      width: 32,
                                      height: 32,
                                      color: white),
                                  isSelected:
                                      viewModel.bmiModel.gender == 'Others',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${sliderProvider.height.toStringAsFixed(1)} cm / "
                          "${sliderProvider.heightInFeet.toStringAsFixed(2)} ft",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 18),
                        ),
                        Slider(
                          value: sliderProvider.height,
                          min: 50,
                          max: 250,
                          divisions: 200,
                          label:
                              "${sliderProvider.height.toStringAsFixed(1)} cm",
                          onChanged: (value) {
                            sliderProvider.updateHeight(value);
                          },
                        ),
                        const CustomText(
                            text: "Height ",
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.w600),
                        Text(
                          "${sliderProvider.weight.toStringAsFixed(1)} kg / "
                          "${sliderProvider.weightInPounds.toStringAsFixed(1)} lbs",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 18),
                        ),
                        Slider(
                          value: sliderProvider.weight,
                          min: 30,
                          max: 180,
                          divisions: 150,
                          label:
                              "${sliderProvider.weight.toStringAsFixed(1)} kg",
                          onChanged: (value) {
                            sliderProvider.updateWeight(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      final result = sliderProvider.calculateBMI();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                    bmiResult: result,
                                  )));
                    },
                    child: const Text("Calculate BMI")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
