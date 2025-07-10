import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/models/bmi_model.dart';

void main() {
  group('BMIModel Tests', () {
    test('should create BMIModel with required parameters', () {
      // Arrange & Act
      final bmiModel = BMIModel(gender: 'Male', age: 25.0);

      // Assert
      expect(bmiModel.gender, equals('Male'));
      expect(bmiModel.age, equals(25.0));
      expect(bmiModel.category, isNull);
    });

    test('should create BMIModel with optional category', () {
      // Arrange & Act
      final bmiModel = BMIModel(
        gender: 'Female',
        age: 30.0,
        category: 'Normal weight',
      );

      // Assert
      expect(bmiModel.gender, equals('Female'));
      expect(bmiModel.age, equals(30.0));
      expect(bmiModel.category, equals('Normal weight'));
    });

    group('copyWith method', () {
      late BMIModel originalModel;

      setUp(() {
        originalModel = BMIModel(
          gender: 'Male',
          age: 25.0,
          category: 'Normal weight',
        );
      });

      test('should copy with updated gender', () {
        // Act
        final updatedModel = originalModel.copyWith(gender: 'Female');

        // Assert
        expect(updatedModel.gender, equals('Female'));
        expect(updatedModel.age, equals(25.0));
        expect(updatedModel.category, equals('Normal weight'));
      });

      test('should copy with updated age', () {
        // Act
        final updatedModel = originalModel.copyWith(age: 30.0);

        // Assert
        expect(updatedModel.gender, equals('Male'));
        expect(updatedModel.age, equals(30.0));
        expect(updatedModel.category, equals('Normal weight'));
      });

      test('should copy with updated category', () {
        // Act
        final updatedModel = originalModel.copyWith(category: 'Overweight');

        // Assert
        expect(updatedModel.gender, equals('Male'));
        expect(updatedModel.age, equals(25.0));
        expect(updatedModel.category, equals('Overweight'));
      });

      test('should copy with multiple updated fields', () {
        // Act
        final updatedModel = originalModel.copyWith(
          gender: 'Others',
          age: 35.0,
          category: 'Underweight',
        );

        // Assert
        expect(updatedModel.gender, equals('Others'));
        expect(updatedModel.age, equals(35.0));
        expect(updatedModel.category, equals('Underweight'));
      });

      test('should copy with no changes when no parameters provided', () {
        // Act
        final copiedModel = originalModel.copyWith();

        // Assert
        expect(copiedModel.gender, equals(originalModel.gender));
        expect(copiedModel.age, equals(originalModel.age));
        expect(copiedModel.category, equals(originalModel.category));
      });

      test('should copy with null category', () {
        // Act
        final updatedModel = originalModel.copyWith(category: null);

        // Assert
        expect(updatedModel.gender, equals('Male'));
        expect(updatedModel.age, equals(25.0));
        expect(updatedModel.category, isNull);
      });
    });

    test('should handle edge cases for gender values', () {
      // Test various gender values
      final genders = ['Male', 'Female', 'Others', 'Non-binary', ''];

      for (String gender in genders) {
        final model = BMIModel(gender: gender, age: 25.0);
        expect(model.gender, equals(gender));
      }
    });

    test('should handle edge cases for age values', () {
      // Test various age values
      final ages = [0.0, 1.0, 18.0, 65.0, 100.0, 150.0];

      for (double age in ages) {
        final model = BMIModel(gender: 'Male', age: age);
        expect(model.age, equals(age));
      }
    });
  });
}
