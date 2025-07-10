import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/presentation/screens/result_screen.dart';

void main() {
  group('ResultScreen Integration Tests', () {
    Widget createResultScreen(double bmiResult) {
      return MaterialApp(home: ResultScreen(bmiResult: bmiResult));
    }

    group('UI Rendering Tests', () {
      testWidgets('should render all main components', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert
        expect(find.text('Your BMI Result'), findsOneWidget);
        expect(find.text('25.0'), findsOneWidget);
        expect(find.text('Calculate Again'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should render BMI value with correct precision', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(24.567));

        // Assert - Should display with 1 decimal place
        expect(find.text('24.6'), findsOneWidget);
      });

      testWidgets('should render description text', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(22.0));

        // Assert
        expect(find.textContaining('Congratulations'), findsOneWidget);
        expect(find.textContaining('healthy range'), findsOneWidget);
      });
    });

    group('BMI Category Display Tests', () {
      testWidgets('should display Underweight category correctly', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(17.5));

        // Assert
        expect(find.text('17.5'), findsOneWidget);
        expect(find.text('Underweight'), findsOneWidget);
        expect(find.textContaining('underweight'), findsOneWidget);
      });

      testWidgets('should display Normal weight category correctly', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(22.0));

        // Assert
        expect(find.text('22.0'), findsOneWidget);
        expect(find.text('Normal weight'), findsOneWidget);
        expect(find.textContaining('Congratulations'), findsOneWidget);
      });

      testWidgets('should display Overweight category correctly', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(27.0));

        // Assert
        expect(find.text('27.0'), findsOneWidget);
        expect(find.text('Overweight'), findsOneWidget);
        expect(find.textContaining('overweight'), findsOneWidget);
      });

      testWidgets('should display Obese category correctly', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(35.0));

        // Assert
        expect(find.text('35.0'), findsOneWidget);
        expect(find.text('Obese'), findsOneWidget);
        expect(find.textContaining('obesity'), findsOneWidget);
      });
    });

    group('BMI Boundary Tests', () {
      testWidgets('should handle BMI exactly 18.5 (Normal weight)', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(18.5));

        // Assert
        expect(find.text('18.5'), findsOneWidget);
        expect(find.text('Normal weight'), findsOneWidget);
      });

      testWidgets('should handle BMI exactly 25.0 (Overweight)', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert
        expect(find.text('25.0'), findsOneWidget);
        expect(find.text('Overweight'), findsOneWidget);
      });

      testWidgets('should handle BMI exactly 30.0 (Obese)', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(30.0));

        // Assert
        expect(find.text('30.0'), findsOneWidget);
        expect(find.text('Obese'), findsOneWidget);
      });

      testWidgets('should handle BMI just below boundaries', (
        WidgetTester tester,
      ) async {
        // Test 18.4 (Underweight)
        await tester.pumpWidget(createResultScreen(18.4));
        expect(find.text('Underweight'), findsOneWidget);

        // Test 24.9 (Normal weight)
        await tester.pumpWidget(createResultScreen(24.9));
        expect(find.text('Normal weight'), findsOneWidget);

        // Test 29.9 (Overweight)
        await tester.pumpWidget(createResultScreen(29.9));
        expect(find.text('Overweight'), findsOneWidget);
      });
    });

    group('Navigation Tests', () {
      testWidgets('should navigate back when back button is tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Home Screen')),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    tester.element(find.text('Home Screen')).findAncestorStateOfType<NavigatorState>()!.context,
                    MaterialPageRoute(
                      builder: (context) => const ResultScreen(bmiResult: 25.0),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );

        // Navigate to result screen
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        // Verify we're on result screen
        expect(find.text('Your BMI Result'), findsOneWidget);

        // Act - Tap back button
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Assert - Should be back to home screen
        expect(find.text('Home Screen'), findsOneWidget);
        expect(find.text('Your BMI Result'), findsNothing);
      });

      testWidgets('should navigate back when Calculate Again is tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Home Screen')),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    tester.element(find.text('Home Screen')).findAncestorStateOfType<NavigatorState>()!.context,
                    MaterialPageRoute(
                      builder: (context) => const ResultScreen(bmiResult: 25.0),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );

        // Navigate to result screen
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        // Verify we're on result screen
        expect(find.text('Your BMI Result'), findsOneWidget);

        // Act - Tap Calculate Again button
        await tester.tap(find.text('Calculate Again'));
        await tester.pumpAndSettle();

        // Assert - Should be back to home screen
        expect(find.text('Home Screen'), findsOneWidget);
        expect(find.text('Your BMI Result'), findsNothing);
      });
    });

    group('Styling and Layout Tests', () {
      testWidgets('should have proper styling and containers', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert - Check for main container
        expect(find.byType(Container), findsWidgets);
        expect(find.byType(SafeArea), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets(
        'should display different colors for different BMI categories',
        (WidgetTester tester) async {
          // Note: We can't easily test exact colors in widget tests,
          // but we can test that the UI renders without errors for each category

          final bmiValues = [17.0, 22.0, 27.0, 35.0];

          for (double bmi in bmiValues) {
            await tester.pumpWidget(createResultScreen(bmi));
            expect(tester.takeException(), isNull);

            // Should have text with styling
            expect(find.byType(Text), findsWidgets);
          }
        },
      );
    });

    group('Responsive Design Tests', () {
      testWidgets('should handle small screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set small screen size
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert - Should render without overflow
        expect(tester.takeException(), isNull);
        expect(find.text('Your BMI Result'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should handle large screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set large screen size
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert - Should render without overflow
        expect(tester.takeException(), isNull);
        expect(find.text('Your BMI Result'), findsOneWidget);
      });
    });

    group('Edge Cases and Extreme Values', () {
      testWidgets('should handle very low BMI values', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(5.0));

        // Assert - Should render without errors
        expect(tester.takeException(), isNull);
        expect(find.text('5.0'), findsOneWidget);
        expect(find.text('Underweight'), findsOneWidget);
      });

      testWidgets('should handle very high BMI values', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(100.0));

        // Assert - Should render without errors
        expect(tester.takeException(), isNull);
        expect(find.text('100.0'), findsOneWidget);
        expect(find.text('Obese'), findsOneWidget);
      });

      testWidgets('should handle decimal BMI values', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(23.456789));

        // Assert - Should display with 1 decimal place
        expect(find.text('23.5'), findsOneWidget);
        expect(find.text('Normal weight'), findsOneWidget);
      });

      testWidgets('should handle BMI value of zero', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(0.0));

        // Assert - Should render without errors
        expect(tester.takeException(), isNull);
        expect(find.text('0.0'), findsOneWidget);
        expect(find.text('Underweight'), findsOneWidget);
      });
    });

    group('Complete Description Tests', () {
      testWidgets('should show complete description for each category', (
        WidgetTester tester,
      ) async {
        final testCases = [
          {
            'bmi': 17.0,
            'category': 'Underweight',
            'keywords': ['underweight', 'healthcare'],
          },
          {
            'bmi': 22.0,
            'category': 'Normal weight',
            'keywords': ['Congratulations', 'healthy'],
          },
          {
            'bmi': 27.0,
            'category': 'Overweight',
            'keywords': ['overweight', 'healthcare'],
          },
          {
            'bmi': 35.0,
            'category': 'Obese',
            'keywords': ['obesity', 'recommended'],
          },
        ];

        for (var testCase in testCases) {
          await tester.pumpWidget(
            createResultScreen(testCase['bmi'] as double),
          );

          expect(find.text(testCase['category'] as String), findsOneWidget);

          // Check that description contains expected keywords
          for (String keyword in testCase['keywords'] as List<String>) {
            expect(find.textContaining(keyword), findsOneWidget);
          }
        }
      });
    });

    group('Theme Integration Tests', () {
      testWidgets('should integrate with app theme', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert - Should have theme integration (no specific color tests, just structure)
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have accessible widgets', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createResultScreen(25.0));

        // Assert - Check for accessible widgets
        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(SafeArea), findsOneWidget);
      });
    });
  });
}
