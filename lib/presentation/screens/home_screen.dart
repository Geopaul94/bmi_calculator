import 'package:bmi_calculator/presentation/widgets/custome_gender_container.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final viewModel = Provider.of<BMIViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
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
                  child: Container(
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
                                  icon: Icon(Icons.male),
                                  isSelected: viewModel.bmiModel.gender == 'Male',
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => viewModel.updateGender('Female'),
                                child: CustomeGenderContainer(
                                  text: "Female",
                                  icon: Icon(Icons.female),
                                  isSelected: viewModel.bmiModel.gender == 'Female',
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8.0 : 16.0),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => viewModel.updateGender('Others'),
                                child: CustomeGenderContainer(
                                  text: "Others",
                                  icon: Icon(Icons.male),
                                  isSelected: viewModel.bmiModel.gender == 'Others',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
