import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/app_config_provider.dart';

class MyCustomTheme {
  final BuildContext context;
  MyCustomTheme(this.context);

  static Color primaryColor = const Color(0xFF5D9CEC);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF000000);
  static Color greyColor = const Color(0xFFC8C9CB);
  static Color greenColor = const Color(0xFF61E757);
  static Color redColor = const Color(0xFFEC4B4B);
  static Color bodyColor = const Color(0xFFDFECDB);
  static Color darkBodyColor = const Color(0xFF060E1E);
  static Color darkContainerColor = const Color(0xFF141922);
  static Color timeColor = const Color(0xFF363636);

  ThemeData get mylightTheme {
    final provider = Provider.of<provider_config>(context);
    return ThemeData(
      scaffoldBackgroundColor: provider.appTheme == ThemeMode.dark ? darkBodyColor : bodyColor,
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 12,color: provider.appTheme == ThemeMode.dark ? blackColor : whiteColor),
        labelSmall: TextStyle(fontSize: 12,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleSmall: TextStyle(fontSize: 15,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleLarge: TextStyle(fontSize: 22,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: whiteColor),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
      ),
    );
  }
  ThemeData get mydarkTheme {
    final provider = Provider.of<provider_config>(context);
    return ThemeData(
      scaffoldBackgroundColor: provider.appTheme == ThemeMode.dark ? darkBodyColor : bodyColor,
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 12,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        labelSmall: TextStyle(fontSize: 12,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleSmall: TextStyle(fontSize: 15,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
        titleLarge: TextStyle(fontSize: 22,color: provider.appTheme == ThemeMode.dark ? whiteColor : blackColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: whiteColor),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
      ),
    );
  }
}
