import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/presentation/widgets/custom_button.dart';
import 'package:bmi_calculator/presentation/widgets/custome_gender_container.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';

void main() {
  group('Custom Widgets Tests', () {
    group('CustomButton Widget Tests', () {
      late HeightWeightSlider mockSliderProvider;

      setUp(() {
        mockSliderProvider = HeightWeightSlider();
      });

      testWidgets('should render CustomButton correctly', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Assert
        expect(find.text('Calculate BMI'), findsOneWidget);
        expect(find.byType(CustomButton), findsOneWidget);
        expect(find.byType(InkWell), findsOneWidget);
      });

      testWidgets('should have correct styling', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Act
        final containerWidget = tester.widget<Container>(
          find
              .ancestor(
                of: find.text('Calculate BMI'),
                matching: find.byType(Container),
              )
              .first,
        );

        // Assert
        expect(containerWidget.decoration, isA<BoxDecoration>());
        final decoration = containerWidget.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
        expect(decoration.borderRadius, isA<BorderRadius>());
        expect(decoration.boxShadow, isNotNull);
      });

      testWidgets('should respond to tap', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        // Assert - Should navigate to result screen
        expect(find.text('Your BMI Result'), findsOneWidget);
      });

      testWidgets('should calculate BMI on tap', (WidgetTester tester) async {
        // Arrange
        mockSliderProvider.updateHeight(170.0);
        mockSliderProvider.updateWeight(70.0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        // Assert - Should show calculated BMI
        expect(find.text('Your BMI Result'), findsOneWidget);
        // BMI should be calculated as 70 / (1.7 * 1.7) ≈ 24.2
        expect(find.textContaining('24.'), findsOneWidget);
      });

      testWidgets('should be responsive on small screen', (
        WidgetTester tester,
      ) async {
        // Arrange - Set small screen size
        await tester.binding.setSurfaceSize(const Size(400, 800));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Act
        final containerWidget = tester.widget<Container>(
          find
              .ancestor(
                of: find.text('Calculate BMI'),
                matching: find.byType(Container),
              )
              .first,
        );

        // Assert - Should use full width on small screen  
        expect(containerWidget.constraints?.maxWidth, equals(double.infinity));
      });

      testWidgets('should be responsive on large screen', (
        WidgetTester tester,
      ) async {
        // Arrange - Set large screen size
        await tester.binding.setSurfaceSize(const Size(800, 600));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(sliderProvider: mockSliderProvider),
            ),
          ),
        );

        // Act
        final containerWidget = tester.widget<Container>(
          find
              .ancestor(
                of: find.text('Calculate BMI'),
                matching: find.byType(Container),
              )
              .first,
        );

        // Assert - Should use percentage width on large screen
        expect(containerWidget.constraints?.maxWidth, equals(800 * 0.4));
      });
    });

    group('CustomGenderContainer Widget Tests', () {
      testWidgets('should render with icon correctly', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Male',
                icon: const Icon(Icons.male),
                isSelected: false,
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Male'), findsOneWidget);
        expect(find.byIcon(Icons.male), findsOneWidget);
        expect(find.byType(CustomGenderContainer), findsOneWidget);
      });

      testWidgets('should render with image correctly', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Others',
                imageOthers: Image.asset(
                  'assets/images/test.png',
                  width: 32,
                  height: 32,
                ),
                isSelected: false,
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Others'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('should show selected state correctly', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Female',
                icon: const Icon(Icons.female),
                isSelected: true,
              ),
            ),
          ),
        );

        // Act
        final containerWidget = tester.widget<Container>(
          find.byType(Container).first,
        );

        // Assert
        final decoration = containerWidget.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.blue));
        expect(decoration.border?.top.color, equals(Colors.white));
      });

      testWidgets('should show unselected state correctly', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Male',
                icon: const Icon(Icons.male),
                isSelected: false,
              ),
            ),
          ),
        );

        // Act
        final containerWidget = tester.widget<Container>(
          find.byType(Container).first,
        );

        // Assert
        final decoration = containerWidget.decoration as BoxDecoration;
        expect(decoration.color, isNot(equals(Colors.blue)));
        expect(decoration.border?.top.color, equals(Colors.grey[600]));
      });

      testWidgets('should handle small screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set small screen size
        await tester.binding.setSurfaceSize(const Size(400, 800));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Male',
                icon: const Icon(Icons.male),
                isSelected: false,
              ),
            ),
          ),
        );

        // Act
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.male));
        final textWidget = tester.widget<Text>(find.text('Male'));

        // Assert - Should use smaller sizes on small screen
        expect(iconWidget.size, equals(24.0));
        expect(textWidget.style?.fontSize, equals(14.0));
      });

      testWidgets('should handle large screen layout', (
        WidgetTester tester,
      ) async {
        // Arrange - Set large screen size
        await tester.binding.setSurfaceSize(const Size(800, 600));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Female',
                icon: const Icon(Icons.female),
                isSelected: false,
              ),
            ),
          ),
        );

        // Act
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.female));
        final textWidget = tester.widget<Text>(find.text('Female'));

        // Assert - Should use larger sizes on large screen
        expect(iconWidget.size, equals(32.0));
        expect(textWidget.style?.fontSize, equals(18.0));
      });

      testWidgets('should use FittedBox to prevent overflow', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: CustomGenderContainer(
                  text: 'Very Long Gender Text',
                  icon: const Icon(Icons.person),
                  isSelected: false,
                ),
              ),
            ),
          ),
        );

        // Assert - Should not overflow
        expect(find.byType(FittedBox), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle both icon and imageOthers parameters', (
        WidgetTester tester,
      ) async {
        // Test with icon
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Male',
                icon: const Icon(Icons.male),
                isSelected: false,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.male), findsOneWidget);
        expect(find.byType(Image), findsNothing);

        // Test with imageOthers
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(
                text: 'Others',
                imageOthers: Image.network('https://example.com/image.png'),
                isSelected: false,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
      });

      testWidgets('should handle neither icon nor imageOthers', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomGenderContainer(text: 'Custom', isSelected: false),
            ),
          ),
        );

        // Assert - Should still render text without icons
        expect(find.text('Custom'), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        expect(find.byType(Image), findsNothing);
      });
    });
  });
}
