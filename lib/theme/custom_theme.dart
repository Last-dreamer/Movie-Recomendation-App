import 'package:flutter/material.dart';
import 'package:movie_recomendation/theme/palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(Palette.red500.value, {
          100: Palette.red100,
          200: Palette.red100,
          300: Palette.red100,
          400: Palette.red100,
          500: Palette.red100,
          600: Palette.red100,
          700: Palette.red100,
          800: Palette.red100,
          900: Palette.red100
        }),
        // accentColor: Palette.red500,
        colorSchemeSeed: Palette.red500,
        scaffoldBackgroundColor: Palette.almostBlack,
        appBarTheme:
            AppBarTheme(elevation: 0, backgroundColor: Palette.almostBlack),
        textTheme: theme.primaryTextTheme
            .copyWith(
                button: theme.primaryTextTheme.button?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))
            .apply(displayColor: Colors.white),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(backgroundColor: Palette.red500)));
  }
}
