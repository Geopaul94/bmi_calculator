// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';

void main() {
  testWidgets('BMI Calculator App Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HeightWeightSlider()),
          ChangeNotifierProvider(create: (_) => BMIViewModel()),
        ],
        child: const MaterialApp(
          home: MyApp(),
        ),
      ),
    );

    // Verify that the initial gender selection is present
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);
    expect(find.text('Others'), findsOneWidget);

    // Verify that height and weight sliders are present
    expect(find.byType(Slider), findsNWidgets(2));
  });

  testWidgets('Gender Selection Test', (WidgetTester tester) async {
    final bmiViewModel = BMIViewModel();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HeightWeightSlider()),
          ChangeNotifierProvider.value(value: bmiViewModel),
        ],
        child: const MaterialApp(
          home: MyApp(),
        ),
      ),
    );

    // Find and tap the Female gender container
    final femaleContainer = find.text('Male');
    expect(femaleContainer, findsOneWidget);

    await tester.tap(femaleContainer);
    await tester.pumpAndSettle();

    // Verify that the gender was updated
    expect(bmiViewModel.bmiModel.gender, equals('Male'));
  });

  testWidgets('Calculate BMI Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HeightWeightSlider()),
          ChangeNotifierProvider(create: (_) => BMIViewModel()),
        ],
        child: const MaterialApp(
          home: MyApp(),
        ),
      ),
    );

    // Find and verify the Calculate BMI button
    expect(find.text('Calculate BMI'), findsOneWidget);
  });
}
