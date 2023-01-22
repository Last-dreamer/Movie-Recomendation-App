import 'package:flutter/material.dart';
import 'package:movie_recomendation/core/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onPress,
      required this.text,
      this.width = double.infinity});

  final VoidCallback onPress;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius / 2)),
          fixedSize: Size(width, 48),
        ),
        onPressed: onPress,
        child: Row(
          children: [Text(text, style: Theme.of(context).textTheme.button)],
        ),
      ),
    );
  }
}
