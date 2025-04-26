import 'package:flutter/material.dart';
import '../models/bmi_model.dart';

class BMIViewModel extends ChangeNotifier {
  BMIModel _bmiModel = BMIModel(
    height: 0,
    weight: 0,
    gender: 'Male',
  );

  BMIModel get bmiModel => _bmiModel;

  void updateGender(String gender) {
    _bmiModel = _bmiModel.copyWith(gender: gender);
    notifyListeners();
  }

  void updateHeight(double height) {
    _bmiModel = _bmiModel.copyWith(height: height);
    calculateBMI();
  }

  void updateWeight(double weight) {
    _bmiModel = _bmiModel.copyWith(weight: weight);
    calculateBMI();
  }

  void calculateBMI() {
    if (_bmiModel.height > 0 && _bmiModel.weight > 0) {
      final bmi = _bmiModel.weight / ((_bmiModel.height / 100) * (_bmiModel.height / 100));
      String category;
      
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi < 25) {
        category = 'Normal';
      } else if (bmi < 30) {
        category = 'Overweight';
      } else {
        category = 'Obese';
      }

      _bmiModel = _bmiModel.copyWith(
        bmi: double.parse(bmi.toStringAsFixed(1)),
        category: category,
      );
      notifyListeners();
    }
  }
} 