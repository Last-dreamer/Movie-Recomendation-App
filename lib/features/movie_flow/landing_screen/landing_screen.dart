import 'package:flutter/material.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen(
      {super.key, required this.nextPage, required this.previousPage});

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text(
                "Let's find a movie",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Image.asset("images/background.png"),
              const Spacer(),
              PrimaryButton(onPress: nextPage, text: "Get Started"),
              const SizedBox(
                height: kMediumSpacing,
              )
            ],
          ),
        ));
  }
}
