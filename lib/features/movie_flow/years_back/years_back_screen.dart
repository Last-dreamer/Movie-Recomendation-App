import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recomendation/features/movie_flow/result/result_screen.dart';

class YearsBackScreen extends ConsumerWidget {
  const YearsBackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed:
                ref.read(movieFlowControllerProvider.notifier).previousPage),
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
                  "${ref.watch(movieFlowControllerProvider).yearsBack.ceil()}",
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
                label:
                    "${ref.watch(movieFlowControllerProvider).yearsBack.ceil()}",
                value:
                    ref.watch(movieFlowControllerProvider).yearsBack.toDouble(),
                onChanged: (value) {
                  ref
                      .read(movieFlowControllerProvider.notifier)
                      .updateYearsBack(value.toInt());
                }),
            const Spacer(),
            PrimaryButton(
                onPress: () => Navigator.of(context).push(ResultScreen.route()),
                text: "Amazing"),
            const SizedBox(
              height: kMediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
