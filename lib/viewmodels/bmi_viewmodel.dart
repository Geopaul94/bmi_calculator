import 'package:flutter/material.dart';
import '../models/bmi_model.dart';

class BMIViewModel extends ChangeNotifier {
  BMIModel _bmiModel = BMIModel(
    gender: "Male",
    age: 0,
  );

  BMIModel get bmiModel => _bmiModel;

  void updateGender(String gender) {
    _bmiModel = _bmiModel.copyWith(gender: gender);
    notifyListeners();
  }
}
