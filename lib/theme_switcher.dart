import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes.dart';

class ThemeSwitcher extends ChangeNotifier {
  static final ThemeSwitcher _singleton = ThemeSwitcher._internal();

  factory ThemeSwitcher() {
    return _singleton;
  }

  ThemeSwitcher._internal();

  ThemeData _theme = lightTheme;

  void switchTheme() {
    if (_theme == lightTheme) {
      _theme = darkTheme;
    } else {
      _theme = lightTheme;
    }
    notifyListeners();
  }

  ThemeData get theme => _theme;
}
