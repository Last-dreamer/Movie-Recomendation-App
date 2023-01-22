import 'package:flutter/material.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen(
      {super.key, required this.nextPage, required this.previousPage});
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rating = 5;

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
              "Select a minimum rating\nranging from 1-10",
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${rating.ceil()}",
                  style: theme.textTheme.headline5,
                ),
                const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 62,
                ),
              ],
            ),
            const Spacer(),
            Slider(
                min: 1,
                max: 10,
                divisions: 10,
                label: "${rating.ceil()}",
                value: rating,
                onChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                }),
            const Spacer(),
            PrimaryButton(onPress: widget.nextPage, text: "Yes please"),
            const SizedBox(
              height: kMediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
