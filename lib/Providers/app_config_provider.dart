import 'package:flutter/material.dart';

class provider_config extends ChangeNotifier{
  String appLanguage = "en";
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){return;}
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode){
    if(appTheme== newMode){return;}
    appTheme = newMode;
    notifyListeners();
  }
}