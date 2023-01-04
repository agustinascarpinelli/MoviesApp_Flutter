



import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
ThemeMode themeMode=ThemeMode.dark;

bool get isDark => themeMode==ThemeMode.dark;

void toggleTheme(bool isOn){
  themeMode=isOn ? ThemeMode.dark : ThemeMode.light;
  notifyListeners();
}


}



class MyThemes {
  static final darkTheme=ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(primary: Colors.grey.shade400),
    primaryColor: Colors.black,
    fontFamily: 'Poppins'

  );

  static final lightTheme=ThemeData(
     scaffoldBackgroundColor: Colors.white,
     colorScheme: ColorScheme.light(primary: Colors.grey),
     primaryColor: Colors.white,
     fontFamily: 'Poppins'
  );
}