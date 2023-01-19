import 'package:flutter/material.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow.dart';
import 'package:movie_recomendation/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        darkTheme: CustomTheme.darkTheme(context),
        themeMode: ThemeMode.dark,
        home: const MovieFlow());
  }
}
