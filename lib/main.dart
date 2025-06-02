import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/viewmodels/height_weight_slider.dart';
import 'package:bmi_calculator/viewmodels/bmi_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeightWeightSlider()),
        ChangeNotifierProvider(create: (context) => BMIViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BMI Calculator ',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF4CAF50),
            secondary: const Color(0xFF81C784),
            surface: const Color(0xFF1E1E1E),
            error: Colors.red.shade400,
          ),
          scaffoldBackgroundColor: Colors.black,
          sliderTheme: SliderThemeData(
            activeTrackColor: const Color(0xFF4CAF50),
            inactiveTrackColor: Colors.grey.shade800,
            thumbColor: const Color(0xFF4CAF50),
            overlayColor: const Color(0xFF4CAF50).withOpacity(0.2),
            valueIndicatorColor: const Color(0xFF4CAF50),
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
