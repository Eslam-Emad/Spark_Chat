import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class AppTheme {
  static const appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.white,
  );

  static final tabBarTheme = TabBarTheme(
    unselectedLabelColor: Colors.black54,
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Palette.kTheme),
  );

  static final dividerTheme = const DividerThemeData().copyWith(thickness: 1.0, indent: 75.0);

  static ThemeData lightTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        appBarTheme: appBarTheme,
        tabBarTheme: tabBarTheme,
        primaryColor: Palette.kTheme,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: const IconThemeData(color: Palette.kIconLight),
        dividerTheme: dividerTheme.copyWith(color: Palette.kIconLight),
        textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme)
       .apply(displayColor: Colors.black),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
        primaryColor: Palette.kTheme,
        scaffoldBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerTheme: dividerTheme.copyWith(color: Palette.kBubbleDark),
        tabBarTheme: tabBarTheme.copyWith(unselectedLabelColor: Colors.white70),
        appBarTheme: appBarTheme.copyWith(backgroundColor: Palette.kAppBarDark),
        textTheme: GoogleFonts.comfortaaTextTheme(Theme.of(context).textTheme)
       .apply(displayColor: Colors.white),
      );

  static bool isLightTheme(BuildContext context) => MediaQuery.of(context).platformBrightness == Brightness.light;

  TextStyle aclonicaTextStyle = GoogleFonts.aclonica(
    fontSize: 21,
    letterSpacing: 0.7,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w300,
  );

  static mainOutLinedBorder(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(45.0),
      borderSide: BorderSide(
        width: 1.5,
        style: BorderStyle.solid,
        color: AppTheme.isLightTheme(context) ? const Color(0xFFC4C4C4) : const Color(0xFF393737),
      ));
  
  static searchOutLinedBorder(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 1.5,
        style: BorderStyle.solid,
        color: AppTheme.isLightTheme(context) ? const Color(0xFFC4C4C4) : const Color(0xFF393737),
      ));
}
