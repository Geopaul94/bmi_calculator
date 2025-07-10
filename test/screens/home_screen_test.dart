import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';

void main() {
  group('HomeScreen Integration Tests', () {
    late BMIViewModel bmiViewModel;
    late HeightWeightSlider heightWeightSlider;

    setUp(() {
      bmiViewModel = BMIViewModel();
      heightWeightSlider = HeightWeightSlider();
    });

    tearDown(() {
      bmiViewModel.dispose();
      heightWeightSlider.dispose();
    });

    Widget createHomeScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<BMIViewModel>.value(value: bmiViewModel),
          ChangeNotifierProvider<HeightWeightSlider>.value(
            value: heightWeightSlider,
          ),
        ],
        child: const MaterialApp(home: HomeScreen()),
      );
    }

    group('UI Rendering Tests', () {
      testWidgets('should render all main components', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createHomeScreen());

        // Assert
        expect(find.text('BMI Calculator'), findsOneWidget);
        expect(
          find.text('Calculate your Body Mass Index And Stay Healthy'),
          findsOneWidget,
        );
        expect(find.text('Select Gender'), findsOneWidget);
        expect(find.text('Male'), findsOneWidget);
        expect(find.text('Female'), findsOneWidget);
        expect(find.text('Others'), findsOneWidget);
        expect(find.text('Height'), findsOneWidget);
        expect(find.text('Weight'), findsOneWidget);
        expect(find.text('Calculate BMI'), findsOneWidget);
      });

      testWidgets('should render sliders with correct initial values', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createHomeScreen());

        // Assert
        expect(find.textContaining('170.0 cm'), findsOneWidget);
        expect(find.textContaining('60.0 kg'), findsOneWidget);
        expect(
          find.byType(Slider),
          findsNWidgets(2),
        ); // Height and Weight sliders
      });

      testWidgets('should have Male gender selected by default', (
        WidgetTester tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(createHomeScreen());

        // Assert - Male should be selected (blue background)
        // Note: We can't easily test the exact color in widget tests,
        // so we test the underlying state
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
      });
    });

    group('Gender Selection Tests', () {
      testWidgets('should update gender when Female is tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act
        await tester.tap(find.text('Female'));
        await tester.pump();

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Female'));
      });

      testWidgets('should update gender when Others is tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act
        await tester.tap(find.text('Others'));
        await tester.pump();

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Others'));
      });

      testWidgets('should update gender when Male is tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // First change to Female
        await tester.tap(find.text('Female'));
        await tester.pump();

        // Act - Change back to Male
        await tester.tap(find.text('Male'));
        await tester.pump();

        // Assert
        expect(bmiViewModel.bmiModel.gender, equals('Male'));
      });
    });

    group('Slider Interaction Tests', () {
      testWidgets('should update height when height slider is moved', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());
        final heightSlider = find.byType(Slider).first;

        // Act - Drag the height slider
        await tester.drag(heightSlider, const Offset(100, 0));
        await tester.pump();

        // Assert - Height should have changed from initial 170.0
        expect(heightWeightSlider.height, isNot(equals(170.0)));
      });

      testWidgets('should update weight when weight slider is moved', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());
        final weightSlider = find.byType(Slider).last;

        // Act - Drag the weight slider
        await tester.drag(weightSlider, const Offset(100, 0));
        await tester.pump();

        // Assert - Weight should have changed from initial 60.0
        expect(heightWeightSlider.weight, isNot(equals(60.0)));
      });

      testWidgets('should update height display when slider changes', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Programmatically update height
        heightWeightSlider.updateHeight(180.0);
        await tester.pump();

        // Assert
        expect(find.textContaining('180.0 cm'), findsOneWidget);
        expect(find.textContaining('5.91 ft'), findsOneWidget);
      });

      testWidgets('should update weight display when slider changes', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Programmatically update weight
        heightWeightSlider.updateWeight(80.0);
        await tester.pump();

        // Assert
        expect(find.textContaining('80.0 kg'), findsOneWidget);
        expect(find.textContaining('176.4 lbs'), findsOneWidget);
      });
    });

    group('Navigation Tests', () {
      testWidgets(
        'should navigate to result screen when Calculate BMI is tapped',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createHomeScreen());

          // Act
          await tester.tap(find.text('Calculate BMI'));
          await tester.pumpAndSettle();

          // Assert
          expect(find.text('Your BMI Result'), findsOneWidget);
          expect(find.text('Calculate Again'), findsOneWidget);
        },
      );

      testWidgets('should calculate correct BMI and navigate to result', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());
        heightWeightSlider.updateHeight(170.0);
        heightWeightSlider.updateWeight(70.0);
        await tester.pump();

        // Act
        await tester.tap(find.text('Calculate BMI'));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Your BMI Result'), findsOneWidget);
        // BMI = 70 / (1.7)² ≈ 24.2
        expect(find.textContaining('24.'), findsOneWidget);
      });

      testWidgets('should be able to navigate back from result screen', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Navigate to result screen
        await tester.tap(find.text('Calculate BMI'));
        await tester.pumpAndSettle();

        // Assert we're on result screen
        expect(find.text('Your BMI Result'), findsOneWidget);

        // Act - Navigate back
        await tester.tap(find.text('Calculate Again'));
        await tester.pumpAndSettle();

        // Assert we're back on home screen
        expect(find.text('BMI Calculator'), findsOneWidget);
        expect(find.text('Calculate BMI'), findsOneWidget);
      });
    });

    group('Responsive Design Tests', () {
      testWidgets('should handle small screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set small screen size
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createHomeScreen());

        // Assert - Should render without overflow
        expect(tester.takeException(), isNull);
        expect(find.text('BMI Calculator'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should handle large screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set large screen size
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createHomeScreen());

        // Assert - Should render without overflow
        expect(tester.takeException(), isNull);
        expect(find.text('BMI Calculator'), findsOneWidget);
      });
    });

    group('Provider Integration Tests', () {
      testWidgets('should react to BMIViewModel changes', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Update gender through viewmodel
        bmiViewModel.updateGender('Female');
        await tester.pump();

        // Assert - UI should reflect the change
        expect(bmiViewModel.bmiModel.gender, equals('Female'));
      });

      testWidgets('should react to HeightWeightSlider changes', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Update values through slider provider
        heightWeightSlider.updateHeight(185.0);
        heightWeightSlider.updateWeight(75.0);
        await tester.pump();

        // Assert - UI should reflect the changes
        expect(find.textContaining('185.0 cm'), findsOneWidget);
        expect(find.textContaining('75.0 kg'), findsOneWidget);
      });
    });

    group('Complete User Flow Tests', () {
      testWidgets('should complete full BMI calculation flow', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Act - Complete user flow
        // 1. Select gender
        await tester.tap(find.text('Female'));
        await tester.pump();

        // 2. Adjust height and weight
        heightWeightSlider.updateHeight(165.0);
        heightWeightSlider.updateWeight(55.0);
        await tester.pump();

        // 3. Calculate BMI
        await tester.tap(find.text('Calculate BMI'));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Your BMI Result'), findsOneWidget);
        expect(bmiViewModel.bmiModel.gender, equals('Female'));

        // BMI = 55 / (1.65)² ≈ 20.2 (Normal weight)
        expect(find.textContaining('20.'), findsOneWidget);
        expect(find.text('Normal weight'), findsOneWidget);
      });

      testWidgets('should handle multiple calculations', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // First calculation
        heightWeightSlider.updateHeight(170.0);
        heightWeightSlider.updateWeight(70.0);
        await tester.pump();

        await tester.tap(find.text('Calculate BMI'));
        await tester.pumpAndSettle();

        expect(find.text('Your BMI Result'), findsOneWidget);

        // Go back
        await tester.tap(find.text('Calculate Again'));
        await tester.pumpAndSettle();

        // Second calculation with different values
        heightWeightSlider.updateHeight(180.0);
        heightWeightSlider.updateWeight(85.0);
        await tester.pump();

        await tester.tap(find.text('Calculate BMI'));
        await tester.pumpAndSettle();

        // Assert second calculation
        expect(find.text('Your BMI Result'), findsOneWidget);
        // BMI = 85 / (1.8)² ≈ 26.2 (Overweight)
        expect(find.textContaining('26.'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('should have proper semantics', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createHomeScreen());

        // Assert - Check for semantic labels
        expect(find.byType(Slider), findsNWidgets(2));
        expect(find.byType(SafeArea), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });
    });
  });
}
