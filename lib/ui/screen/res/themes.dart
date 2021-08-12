import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes_colors.dart';
import 'package:places/ui/screen/res/themes_styles.dart';

import 'themes_colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: lmPrimaryColor,
  backgroundColor: lmBackgroundColor,
  primaryColorDark: lmPrimaryColorDark,
  accentColor: lmAccentColor,
  dividerColor: lmBottomNavBarDividerColor,
  iconTheme: IconThemeData(
    color: lmActiveIconColor,
  ),
  scaffoldBackgroundColor: lmScaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    textTheme: TextTheme(
      headline6: lmTextAppBarTitle,
      headline5: lmTextAppBarLeading,
    ),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(
        20.0,
      ),
      color: lmTabBarSelectedLableColor,
    ),
    unselectedLabelColor: lmTabBarUnSelectedLableTextColor,
    labelColor: lmTabBarSelectedLableTextColor,
    labelStyle: lmTextTabBarLable,
    unselectedLabelStyle: lmTextTabBarLable,
  ),
  textTheme: TextTheme(
    headline6: lmTextHeadline6,
    headline5: lmTextHeadline5,
    headline4: lmTextHeadline4,
    headline3: lmTextHeadline3,
    headline2: lmTextHeadline2,
    subtitle2: lmTextSubtitle2,
    subtitle1: lmTextSubtitle1,
    bodyText1: lmTextBody1,
    bodyText2: lmTextBody2,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lmBottomNavBarBackgroundColor,
    selectedItemColor: lmBottomNavBarIconsColor,
    unselectedItemColor: lmBottomNavBarIconsColor,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: lmPrimaryColor,
    inactiveTrackColor: lmAccentColor,
    thumbColor: lmBackgroundColor,
    trackHeight: 1,
    overlayColor: lmPrimaryColor.withOpacity(0.16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);

////////////////

ThemeData darkTheme = ThemeData(
  backgroundColor: dmBackgroundColor,
  primaryColorDark: dmPrimaryColorDark,
  accentColor: dmAccentColor,
  dividerColor: dmBottomNavBarDividerColor,
  iconTheme: IconThemeData(
    color: dmActiveIconColor,
  ),
  scaffoldBackgroundColor: dmScaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    textTheme: TextTheme(
      headline6: dmTextAppBarTitle,
    ),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(
        20.0,
      ),
      color: dmTabBarSelectedLableColor,
    ),
    unselectedLabelColor: dmTabBarUnSelectedLableTextColor,
    labelColor: dmTabBarSelectedLableTextColor,
    labelStyle: dmTextTabBarLable,
    unselectedLabelStyle: dmTextTabBarLable,
  ),
  textTheme: TextTheme(
    headline6: dmTextHeadline6,
    headline5: dmTextHeadline5,
    headline4: dmTextHeadline4,
    headline3: dmTextHeadline3,
    subtitle2: dmTextSubtitle2,
    subtitle1: dmTextSubtitle1,
    bodyText1: dmTextBody1,
    bodyText2: dmTextBody2,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: dmBottomNavBarBackgroundColor,
    selectedIconTheme: IconThemeData(
      color: dmBottomNavBarIconsColor,
    ),
    selectedItemColor: dmBottomNavBarIconsColor,
    unselectedIconTheme: IconThemeData(
      color: dmBottomNavBarIconsColor,
    ),
    unselectedItemColor: dmBottomNavBarIconsColor,
  ),
);
