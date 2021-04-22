import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/theme_switcher.dart';
import 'package:places/ui/screen/res/themes_styles.dart';
import 'package:places/ui/widgets/custom_bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    ThemeSwitcher themeSwitcher = ThemeSwitcher();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Настройки',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Темная тема',
                  style: Theme.of(context).textTheme.headline3,
                ),
                CupertinoSwitch(
                  value: _isDarkTheme,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      _isDarkTheme = value;
                      themeSwitcher.switchTheme();
                    });
                  },
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Смотреть туториал',
                  style: Theme.of(context).textTheme.headline3,
                ),
                IconButton(
                    icon: SvgPicture.asset(
                      'res/images/icons/Info.svg',
                      height: 24.0,
                      width: 24.0,
                    ),
                    onPressed: () {}),
              ],
            ),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
