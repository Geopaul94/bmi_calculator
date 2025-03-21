import 'package:bmi/utilities/themes/dark_mode.dart';
import 'package:bmi/utilities/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData =darkMode;
  ThemeData  get   themeData =>  _themeData;
  bool get isDarkMode => _themeData== darkMode;


  set themeData(ThemeData themeData){
    _themeData=themeData;


    notifyListeners();  
  }
  void toggletheme(){
    if(_themeData==lightMode){
      themeData=darkMode;
    }else{
      themeData=lightMode;
    }
  }
}