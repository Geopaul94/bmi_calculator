import 'package:flutter/material.dart';

class HeightWeightSlider extends ChangeNotifier {
  double _height = 170.0; // in cm
  double _weight = 60.0; // in kg

  double get height => _height;
  double get weight => _weight;

  double get heightInFeet => _height / 30.48;
  double get weightInPounds => _weight * 2.20462;

  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  void updateWeight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void reset() {
    _height = 170.0;
    _weight = 60.0;
    notifyListeners();
  }

  double calculateBMI() {
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);
    return bmi;
  }
}
