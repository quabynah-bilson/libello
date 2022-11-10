import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libello/core/extensions.dart';

class ThemeConfig {
  static const kOrange = Colors.orange,
      kAmber = Colors.amber,
      kGreen = Colors.green,
      kRed = Colors.red;

  static const _defaultFont = GoogleFonts.spaceGrotesk,
      _secondaryFont = GoogleFonts.dmSans,
      _tertiaryFont = GoogleFonts.dmMono;

  static TextTheme _kDefaultTextTheme(Color textColor) => TextTheme(
        headline1: _defaultFont(
            color: textColor, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: _defaultFont(
            color: textColor, fontWeight: FontWeight.w400, letterSpacing: -0.5),
        headline3: _defaultFont(color: textColor, fontWeight: FontWeight.w600),
        headline4: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5: _defaultFont(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        headline6: _defaultFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        subtitle1: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w700, letterSpacing: 0.15),
        subtitle2: _secondaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        bodyText1: _secondaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.5),
        bodyText2: _defaultFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.25),
        button: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w700, letterSpacing: 1.25),
        caption: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.4),
        overline: _tertiaryFont(
            color: textColor, fontWeight: FontWeight.w500, letterSpacing: 1.5),
      );

  static ThemeData kLightThemeData(BuildContext context) =>
      ThemeData.light(useMaterial3: true).copyWith(
        textTheme: _kDefaultTextTheme(context.colorScheme.onBackground),
      );

  static ThemeData kDarkThemeData(BuildContext context) =>
      ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: _kDefaultTextTheme(context.colorScheme.onBackground),
        scaffoldBackgroundColor: const Color(0xff181818),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff9DC1CE),
          secondary: Color(0xffFDF4A5),
          secondaryContainer: Color(0xffECFDC7),
          tertiary: Color(0xff232323),
          tertiaryContainer: Color(0xff161616),
          background: Color(0xff181818),
          surface: Color(0xff232323),
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onTertiary: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff232323),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xff161616),
          elevation: 3,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme:
              IconThemeData(color: Colors.grey.withOpacity(0.65)),
          selectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.grey.withOpacity(0.65)),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff181818),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      );
}
