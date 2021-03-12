
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'screens/homePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Wasteagram',
          theme: theme,
          home: MyHomePage(),
        );
      }
    );
  }
}

