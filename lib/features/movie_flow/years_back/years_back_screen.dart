import 'package:flutter/material.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';

class YearsBackScreen extends StatefulWidget {
  const YearsBackScreen(
      {super.key, required this.nextPage, required this.previousPage});
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<YearsBackScreen> createState() => _YearsBackScreenState();
}

class _YearsBackScreenState extends State<YearsBackScreen> {
  double yearsBack = 5;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: widget.previousPage),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "How many years back should we check for?",
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${yearsBack.ceil()}",
                  style: theme.textTheme.headline5,
                ),
                Text(
                  "Years Back",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline4?.copyWith(
                      color:
                          theme.textTheme.headline4?.color?.withOpacity(0.64)),
                ),
              ],
            ),
            const Spacer(),
            Slider(
                min: 1,
                max: 10,
                divisions: 10,
                label: "${yearsBack.ceil()}",
                value: yearsBack,
                onChanged: (value) {
                  setState(() {
                    yearsBack = value;
                  });
                }),
            const Spacer(),
            PrimaryButton(onPress: widget.nextPage, text: "Amazing"),
            const SizedBox(
              height: kMediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
