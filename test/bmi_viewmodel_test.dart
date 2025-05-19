import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';

void main() {
  group('BMIViewModel Tests', () {
    late BMIViewModel viewModel;

    setUp(() {
      viewModel = BMIViewModel();
    });

    test('Initial BMI model should have default values', () {
      expect(viewModel.bmiModel.gender, equals('Male'));
      expect(viewModel.bmiModel.age, equals(0));
    });

    test('updateGender should update the gender value', () {
      viewModel.updateGender('Female');
      expect(viewModel.bmiModel.gender, equals('Female'));
    });
  });
}
