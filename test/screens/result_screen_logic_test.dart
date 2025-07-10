import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/presentation/screens/result_screen.dart';

void main() {
  group('ResultScreen Logic Tests', () {
    late ResultScreen resultScreen;

    setUp(() {
      resultScreen = const ResultScreen(bmiResult: 25.0);
    });

    group('BMI Category Classification', () {
      test('should classify BMI < 18.5 as Underweight', () {
        final testCases = [0.0, 10.0, 15.5, 18.0, 18.4];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMICategory(bmi), equals('Underweight'));
        }
      });

      test('should classify BMI 18.5-24.9 as Normal weight', () {
        final testCases = [18.5, 20.0, 22.5, 24.0, 24.9];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMICategory(bmi), equals('Normal weight'));
        }
      });

      test('should classify BMI 25.0-29.9 as Overweight', () {
        final testCases = [25.0, 26.5, 28.0, 29.0, 29.9];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMICategory(bmi), equals('Overweight'));
        }
      });

      test('should classify BMI >= 30.0 as Obese', () {
        final testCases = [30.0, 35.0, 40.0, 50.0, 100.0];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMICategory(bmi), equals('Obese'));
        }
      });

      test('should handle boundary values correctly', () {
        // Test exact boundary values
        expect(
          ResultScreen(bmiResult: 18.5).getBMICategory(18.5),
          equals('Normal weight'),
        );
        expect(
          ResultScreen(bmiResult: 25.0).getBMICategory(25.0),
          equals('Overweight'),
        );
        expect(
          ResultScreen(bmiResult: 30.0).getBMICategory(30.0),
          equals('Obese'),
        );

        // Test just below boundaries
        expect(
          ResultScreen(bmiResult: 18.49).getBMICategory(18.49),
          equals('Underweight'),
        );
        expect(
          ResultScreen(bmiResult: 24.99).getBMICategory(24.99),
          equals('Normal weight'),
        );
        expect(
          ResultScreen(bmiResult: 29.99).getBMICategory(29.99),
          equals('Overweight'),
        );
      });
    });

    group('BMI Color Assignment', () {
      test('should assign blue color for Underweight', () {
        final testCases = [10.0, 15.0, 18.4];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMIColor(bmi), equals(Colors.blue));
        }
      });

      test('should assign green color for Normal weight', () {
        final testCases = [18.5, 22.0, 24.9];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMIColor(bmi), equals(Colors.green));
        }
      });

      test('should assign orange color for Overweight', () {
        final testCases = [25.0, 27.5, 29.9];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMIColor(bmi), equals(Colors.orange));
        }
      });

      test('should assign red color for Obese', () {
        final testCases = [30.0, 35.0, 45.0];

        for (double bmi in testCases) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.getBMIColor(bmi), equals(Colors.red));
        }
      });

      test('should handle boundary color assignments correctly', () {
        // Test exact boundary values
        expect(
          ResultScreen(bmiResult: 18.5).getBMIColor(18.5),
          equals(Colors.green),
        );
        expect(
          ResultScreen(bmiResult: 25.0).getBMIColor(25.0),
          equals(Colors.orange),
        );
        expect(
          ResultScreen(bmiResult: 30.0).getBMIColor(30.0),
          equals(Colors.red),
        );
      });
    });

    group('BMI Description Generation', () {
      test('should provide correct description for Underweight', () {
        final screen = ResultScreen(bmiResult: 17.0);
        final description = screen.getBMIDescription('Underweight');

        expect(description, contains('underweight'));
        expect(description, contains('healthcare provider'));
        expect(description, contains('gain weight'));
      });

      test('should provide correct description for Normal weight', () {
        final screen = ResultScreen(bmiResult: 22.0);
        final description = screen.getBMIDescription('Normal weight');

        expect(description, contains('Congratulations'));
        expect(description, contains('healthy range'));
        expect(description, contains('balanced diet'));
        expect(description, contains('regular exercise'));
      });

      test('should provide correct description for Overweight', () {
        final screen = ResultScreen(bmiResult: 27.0);
        final description = screen.getBMIDescription('Overweight');

        expect(description, contains('overweight'));
        expect(description, contains('healthcare provider'));
        expect(description, contains('manage your weight'));
      });

      test('should provide correct description for Obese', () {
        final screen = ResultScreen(bmiResult: 35.0);
        final description = screen.getBMIDescription('Obese');

        expect(description, contains('obesity'));
        expect(description, contains('recommended'));
        expect(description, contains('healthcare provider'));
        expect(description, contains('weight management'));
      });

      test('should return empty string for unknown category', () {
        final screen = ResultScreen(bmiResult: 22.0);
        final description = screen.getBMIDescription('Unknown Category');

        expect(description, equals(''));
      });

      test('should handle null or empty category', () {
        final screen = ResultScreen(bmiResult: 22.0);

        expect(screen.getBMIDescription(''), equals(''));
        // Note: Cannot test null as the method expects String
      });
    });

    group('Integration Tests', () {
      test('should have consistent category and color for same BMI', () {
        final testBMI = 23.5;
        final screen = ResultScreen(bmiResult: testBMI);

        final category = screen.getBMICategory(testBMI);
        final color = screen.getBMIColor(testBMI);

        expect(category, equals('Normal weight'));
        expect(color, equals(Colors.green));
      });

      test('should handle extreme BMI values', () {
        final extremeValues = [0.0, 100.0, 500.0];

        for (double bmi in extremeValues) {
          final screen = ResultScreen(bmiResult: bmi);

          // Should not throw errors
          expect(() => screen.getBMICategory(bmi), returnsNormally);
          expect(() => screen.getBMIColor(bmi), returnsNormally);

          final category = screen.getBMICategory(bmi);
          expect(() => screen.getBMIDescription(category), returnsNormally);
        }
      });

      test('should provide complete information for typical BMI values', () {
        final typicalBMIs = [16.0, 21.0, 27.0, 35.0];
        final expectedCategories = [
          'Underweight',
          'Normal weight',
          'Overweight',
          'Obese',
        ];
        final expectedColors = [
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.red,
        ];

        for (int i = 0; i < typicalBMIs.length; i++) {
          final bmi = typicalBMIs[i];
          final screen = ResultScreen(bmiResult: bmi);

          final category = screen.getBMICategory(bmi);
          final color = screen.getBMIColor(bmi);
          final description = screen.getBMIDescription(category);

          expect(category, equals(expectedCategories[i]));
          expect(color, equals(expectedColors[i]));
          expect(description.isNotEmpty, isTrue);
        }
      });
    });

    group('Edge Cases and Validation', () {
      test('should handle very small BMI values', () {
        final screen = ResultScreen(bmiResult: 0.1);

        expect(screen.getBMICategory(0.1), equals('Underweight'));
        expect(screen.getBMIColor(0.1), equals(Colors.blue));
      });

      test('should handle very large BMI values', () {
        final screen = ResultScreen(bmiResult: 1000.0);

        expect(screen.getBMICategory(1000.0), equals('Obese'));
        expect(screen.getBMIColor(1000.0), equals(Colors.red));
      });

      test('should handle decimal precision correctly', () {
        final preciseBMIs = [
          18.499999,
          18.500001,
          24.999999,
          25.000001,
          29.999999,
          30.000001,
        ];
        final expectedCategories = [
          'Underweight',
          'Normal weight',
          'Normal weight',
          'Overweight',
          'Overweight',
          'Obese',
        ];

        for (int i = 0; i < preciseBMIs.length; i++) {
          final screen = ResultScreen(bmiResult: preciseBMIs[i]);
          expect(
            screen.getBMICategory(preciseBMIs[i]),
            equals(expectedCategories[i]),
          );
        }
      });

      test('should maintain consistency across multiple calls', () {
        final bmi = 23.7;
        final screen = ResultScreen(bmiResult: bmi);

        // Call methods multiple times
        for (int i = 0; i < 5; i++) {
          expect(screen.getBMICategory(bmi), equals('Normal weight'));
          expect(screen.getBMIColor(bmi), equals(Colors.green));
        }
      });
    });

    group('Constructor Tests', () {
      test('should create ResultScreen with valid BMI result', () {
        const bmi = 25.5;
        const screen = ResultScreen(bmiResult: bmi);

        expect(screen.bmiResult, equals(bmi));
      });

      test('should create ResultScreen with different BMI values', () {
        final bmiValues = [15.0, 20.0, 25.0, 30.0, 40.0];

        for (double bmi in bmiValues) {
          final screen = ResultScreen(bmiResult: bmi);
          expect(screen.bmiResult, equals(bmi));
        }
      });
    });
  });
}
