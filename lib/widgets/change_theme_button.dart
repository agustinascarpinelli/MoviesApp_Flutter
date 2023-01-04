import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDark,
      activeColor: Colors.grey,
      onChanged:(value){
        final provider=Provider.of<ThemeProvider>(context,listen: false);
        provider.toggleTheme(value);
      });
  }
}