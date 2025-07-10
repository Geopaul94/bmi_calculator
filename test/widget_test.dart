import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';

void main() {
  group('BMI Calculator App Integration Tests', () {
    testWidgets('should render main app correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify main app elements are present
      expect(find.text('BMI Calculator'), findsOneWidget);
      expect(find.text('Calculate your Body Mass Index And Stay Healthy'), findsOneWidget);
      expect(find.text('Select Gender'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
      expect(find.text('Others'), findsOneWidget);
      expect(find.text('Calculate BMI'), findsOneWidget);
    });

    testWidgets('should complete basic BMI calculation flow', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Tap the calculate button
      await tester.tap(find.text('Calculate BMI'));
      await tester.pumpAndSettle();

      // Verify we navigated to result screen
      expect(find.text('Your BMI Result'), findsOneWidget);
      expect(find.text('Calculate Again'), findsOneWidget);
    });

    testWidgets('should handle gender selection', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Tap on Female gender
      await tester.tap(find.text('Female'));
      await tester.pump();

      // Tap on Others gender
      await tester.tap(find.text('Others'));
      await tester.pump();

      // App should respond without errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('should have proper provider setup', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Check that sliders are present (indicates providers are working)
      expect(find.byType(Slider), findsNWidgets(2));
      
      // Check that initial values are displayed
      expect(find.textContaining('170.0 cm'), findsOneWidget);
      expect(find.textContaining('60.0 kg'), findsOneWidget);
    });
  });
}
