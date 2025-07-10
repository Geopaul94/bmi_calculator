import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:bmi_calculator/models/bmi_model.dart';

void main() {
  group('BMIViewModel Tests', () {
    late BMIViewModel bmiViewModel;

    setUp(() {
      bmiViewModel = BMIViewModel();
    });

    group('Initial state', () {
      test('should have correct initial BMI model', () {
        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
        expect(bmiViewModel.bmiModel.age, equals(0));
        expect(bmiViewModel.bmiModel.category, isNull);
      });

      test('should have BMIModel as initial type', () {
        // Assert
        expect(bmiViewModel.bmiModel, isA<BMIModel>());
      });
    });

    group('Gender updates', () {
      test('should update gender to Female', () {
        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Female'));
        expect(bmiViewModel.bmiModel.age, equals(0)); // Should remain unchanged
        expect(
          bmiViewModel.bmiModel.category,
          isNull,
        ); // Should remain unchanged
      });

      test('should update gender to Others', () {
        // Act
        bmiViewModel.updateGender('Others');

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Others'));
        expect(bmiViewModel.bmiModel.age, equals(0));
        expect(bmiViewModel.bmiModel.category, isNull);
      });

      test('should update gender to Male (same as initial)', () {
        // Act
        bmiViewModel.updateGender('Male');

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
        expect(bmiViewModel.bmiModel.age, equals(0));
        expect(bmiViewModel.bmiModel.category, isNull);
      });

      test('should notify listeners when gender updates', () {
        // Arrange
        bool listenerCalled = false;
        bmiViewModel.addListener(() {
          listenerCalled = true;
        });

        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(listenerCalled, isTrue);
      });

      test('should notify listeners even for same gender', () {
        // Arrange
        bool listenerCalled = false;
        bmiViewModel.addListener(() {
          listenerCalled = true;
        });

        // Act - Set same gender as initial
        bmiViewModel.updateGender('Male');

        // Assert
        expect(listenerCalled, isTrue);
      });

      test('should handle multiple gender updates', () {
        // Arrange
        int listenerCallCount = 0;
        bmiViewModel.addListener(() {
          listenerCallCount++;
        });

        // Act
        bmiViewModel.updateGender('Female');
        bmiViewModel.updateGender('Others');
        bmiViewModel.updateGender('Male');

        // Assert
        expect(listenerCallCount, equals(3));
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
      });
    });

    group('Edge cases and validation', () {
      test('should handle empty string gender', () {
        // Act
        bmiViewModel.updateGender('');

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals(''));
      });

      test('should handle null gender (if allowed)', () {
        // Note: Since the gender field in BMIModel is non-nullable String,
        // this test is mainly for documentation of expected behavior

        // Act & Assert
        expect(() => bmiViewModel.updateGender(''), returnsNormally);
      });

      test('should handle special gender values', () {
        final specialGenders = [
          'Non-binary',
          'Prefer not to say',
          'Custom',
          'transgender',
          'MALE', // uppercase
          'female', // lowercase
        ];

        for (String gender in specialGenders) {
          bmiViewModel.updateGender(gender);
          expect(bmiViewModel.bmiModel.gender, equals(gender));
        }
      });

      test('should handle very long gender string', () {
        // Arrange
        const longGender =
            'This is a very long gender string that might be used in edge cases for testing purposes and should be handled correctly by the system';

        // Act
        bmiViewModel.updateGender(longGender);

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals(longGender));
      });
    });

    group('State immutability', () {
      test('should create new BMIModel instance on gender update', () {
        // Arrange
        final originalModel = bmiViewModel.bmiModel;

        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(bmiViewModel.bmiModel, isNot(same(originalModel)));
        expect(bmiViewModel.bmiModel.gender, equals('Female'));
      });

      test('should not modify original model when updating gender', () {
        // Arrange
        final originalModel = bmiViewModel.bmiModel;
        final originalGender = originalModel.gender;

        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(
          originalModel.gender,
          equals(originalGender),
        ); // Original unchanged
        expect(
          bmiViewModel.bmiModel.gender,
          equals('Female'),
        ); // New model updated
      });
    });

    group('Listener management', () {
      test('should support multiple listeners', () {
        // Arrange
        bool listener1Called = false;
        bool listener2Called = false;

        bmiViewModel.addListener(() {
          listener1Called = true;
        });

        bmiViewModel.addListener(() {
          listener2Called = true;
        });

        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(listener1Called, isTrue);
        expect(listener2Called, isTrue);
      });

      test('should not call removed listeners', () {
        // Arrange
        bool listenerCalled = false;
        void listener() {
          listenerCalled = true;
        }

        bmiViewModel.addListener(listener);
        bmiViewModel.removeListener(listener);

        // Act
        bmiViewModel.updateGender('Female');

        // Assert
        expect(listenerCalled, isFalse);
      });
    });

    group('BMIModel integration', () {
      test('should maintain model consistency after multiple updates', () {
        // Act
        bmiViewModel.updateGender('Female');
        bmiViewModel.updateGender('Others');
        bmiViewModel.updateGender('Male');

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
        expect(bmiViewModel.bmiModel.age, equals(0));
        expect(bmiViewModel.bmiModel.category, isNull);
      });

      test('should preserve copyWith behavior', () {
        // Arrange
        final initialModel = bmiViewModel.bmiModel;

        // Act
        bmiViewModel.updateGender('Female');
        final updatedModel = bmiViewModel.bmiModel;

        // Assert
        expect(updatedModel.gender, equals('Female'));
        expect(updatedModel.age, equals(initialModel.age));
        expect(updatedModel.category, equals(initialModel.category));
      });
    });

    tearDown(() {
      bmiViewModel.dispose();
    });
  });
}
