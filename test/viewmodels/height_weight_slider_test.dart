import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';

void main() {
  group('HeightWeightSlider Tests', () {
    late HeightWeightSlider heightWeightSlider;

    setUp(() {
      heightWeightSlider = HeightWeightSlider();
    });

    group('Initial values', () {
      test('should have correct initial height', () {
        expect(heightWeightSlider.height, equals(170.0));
      });

      test('should have correct initial weight', () {
        expect(heightWeightSlider.weight, equals(60.0));
      });

      test('should have correct initial height in feet', () {
        // 170 cm / 30.48 ≈ 5.58 feet
        expect(heightWeightSlider.heightInFeet, closeTo(5.58, 0.01));
      });

      test('should have correct initial weight in pounds', () {
        // 60 kg * 2.20462 ≈ 132.28 lbs
        expect(heightWeightSlider.weightInPounds, closeTo(132.28, 0.01));
      });
    });

    group('Height updates', () {
      test('should update height correctly', () {
        // Act
        heightWeightSlider.updateHeight(180.0);

        // Assert
        expect(heightWeightSlider.height, equals(180.0));
      });

      test('should update height in feet when height changes', () {
        // Act
        heightWeightSlider.updateHeight(180.0);

        // Assert
        // 180 cm / 30.48 ≈ 5.91 feet
        expect(heightWeightSlider.heightInFeet, closeTo(5.91, 0.01));
      });

      test('should notify listeners when height updates', () {
        // Arrange
        bool listenerCalled = false;
        heightWeightSlider.addListener(() {
          listenerCalled = true;
        });

        // Act
        heightWeightSlider.updateHeight(190.0);

        // Assert
        expect(listenerCalled, isTrue);
      });

      test('should handle edge case heights', () {
        final testHeights = [50.0, 100.0, 200.0, 250.0];

        for (double height in testHeights) {
          heightWeightSlider.updateHeight(height);
          expect(heightWeightSlider.height, equals(height));
        }
      });
    });

    group('Weight updates', () {
      test('should update weight correctly', () {
        // Act
        heightWeightSlider.updateWeight(70.0);

        // Assert
        expect(heightWeightSlider.weight, equals(70.0));
      });

      test('should update weight in pounds when weight changes', () {
        // Act
        heightWeightSlider.updateWeight(70.0);

        // Assert
        // 70 kg * 2.20462 ≈ 154.32 lbs
        expect(heightWeightSlider.weightInPounds, closeTo(154.32, 0.01));
      });

      test('should notify listeners when weight updates', () {
        // Arrange
        bool listenerCalled = false;
        heightWeightSlider.addListener(() {
          listenerCalled = true;
        });

        // Act
        heightWeightSlider.updateWeight(80.0);

        // Assert
        expect(listenerCalled, isTrue);
      });

      test('should handle edge case weights', () {
        final testWeights = [30.0, 50.0, 100.0, 150.0, 180.0];

        for (double weight in testWeights) {
          heightWeightSlider.updateWeight(weight);
          expect(heightWeightSlider.weight, equals(weight));
        }
      });
    });

    group('Unit conversions', () {
      test('should convert height to feet correctly', () {
        heightWeightSlider.updateHeight(152.4); // 5 feet exactly
        expect(heightWeightSlider.heightInFeet, closeTo(5.0, 0.01));
      });

      test('should convert weight to pounds correctly', () {
        heightWeightSlider.updateWeight(45.36); // 100 pounds exactly
        expect(heightWeightSlider.weightInPounds, closeTo(100.0, 0.01));
      });

      test('should handle zero values in conversions', () {
        heightWeightSlider.updateHeight(0.0);
        heightWeightSlider.updateWeight(0.0);

        expect(heightWeightSlider.heightInFeet, equals(0.0));
        expect(heightWeightSlider.weightInPounds, equals(0.0));
      });
    });

    group('BMI calculation', () {
      test('should calculate BMI correctly for normal values', () {
        // Arrange - Set height to 170cm and weight to 70kg
        heightWeightSlider.updateHeight(170.0);
        heightWeightSlider.updateWeight(70.0);

        // Act
        final bmi = heightWeightSlider.calculateBMI();

        // Assert
        // BMI = 70 / (1.7 * 1.7) ≈ 24.22
        expect(bmi, closeTo(24.22, 0.01));
      });

      test('should calculate BMI correctly for different scenarios', () {
        final testCases = [
          {
            'height': 160.0,
            'weight': 50.0,
            'expectedBMI': 19.53,
          }, // Underweight
          {'height': 175.0, 'weight': 70.0, 'expectedBMI': 22.86}, // Normal
          {'height': 180.0, 'weight': 85.0, 'expectedBMI': 26.23}, // Overweight
          {'height': 165.0, 'weight': 90.0, 'expectedBMI': 33.06}, // Obese
        ];

        for (var testCase in testCases) {
          heightWeightSlider.updateHeight(testCase['height']! as double);
          heightWeightSlider.updateWeight(testCase['weight']! as double);

          final bmi = heightWeightSlider.calculateBMI();
          expect(bmi, closeTo(testCase['expectedBMI']! as double, 0.01));
        }
      });

      test('should handle extreme BMI calculations', () {
        // Very tall and light person
        heightWeightSlider.updateHeight(220.0);
        heightWeightSlider.updateWeight(50.0);
        final extremeLow = heightWeightSlider.calculateBMI();
        expect(extremeLow, closeTo(10.33, 0.01));

        // Short and heavy person
        heightWeightSlider.updateHeight(140.0);
        heightWeightSlider.updateWeight(120.0);
        final extremeHigh = heightWeightSlider.calculateBMI();
        expect(extremeHigh, closeTo(61.22, 0.01));
      });
    });

    group('Reset functionality', () {
      test('should reset to initial values', () {
        // Arrange - Change values
        heightWeightSlider.updateHeight(190.0);
        heightWeightSlider.updateWeight(85.0);

        // Act
        heightWeightSlider.reset();

        // Assert
        expect(heightWeightSlider.height, equals(170.0));
        expect(heightWeightSlider.weight, equals(60.0));
      });

      test('should notify listeners when reset', () {
        // Arrange
        bool listenerCalled = false;
        heightWeightSlider.addListener(() {
          listenerCalled = true;
        });

        // Change values first
        heightWeightSlider.updateHeight(190.0);
        listenerCalled = false; // Reset flag

        // Act
        heightWeightSlider.reset();

        // Assert
        expect(listenerCalled, isTrue);
      });

      test('should reset derived values correctly', () {
        // Arrange - Change values
        heightWeightSlider.updateHeight(200.0);
        heightWeightSlider.updateWeight(100.0);

        // Act
        heightWeightSlider.reset();

        // Assert
        expect(heightWeightSlider.heightInFeet, closeTo(5.58, 0.01));
        expect(heightWeightSlider.weightInPounds, closeTo(132.28, 0.01));
      });
    });

    group('Listener notifications', () {
      test('should not notify listeners for same height value', () {
        // Arrange
        int listenerCallCount = 0;
        heightWeightSlider.addListener(() {
          listenerCallCount++;
        });

        // Act - Set same height value multiple times
        heightWeightSlider.updateHeight(170.0); // Same as initial
        heightWeightSlider.updateHeight(170.0);

        // Assert
        expect(listenerCallCount, equals(2)); // Called for each update
      });

      test('should not notify listeners for same weight value', () {
        // Arrange
        int listenerCallCount = 0;
        heightWeightSlider.addListener(() {
          listenerCallCount++;
        });

        // Act - Set same weight value multiple times
        heightWeightSlider.updateWeight(60.0); // Same as initial
        heightWeightSlider.updateWeight(60.0);

        // Assert
        expect(listenerCallCount, equals(2)); // Called for each update
      });
    });
  });
}
