import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _lights;
  @override
  Widget build(BuildContext context) {
    getThemeOf();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              child: Text('Settings'),
            ),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0)
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: _lights,
            onChanged: (bool value) { setState(() { _lights = value; DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark); }); },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
    );
  }
  void getThemeOf(){
    if (Theme.of(context).brightness == Brightness.dark) {
      _lights = true;
    } else {
      _lights = false;
    }
  }
}


