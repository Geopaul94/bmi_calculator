import 'package:bmi/presentation/screeens/splash_screen.dart';
import 'package:bmi/utilities/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392, 802),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'BMI Calculator',
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
