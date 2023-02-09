import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';

void main() {
  testWidgets('primary button ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PrimaryButton(
        onPress: () {},
        text: "ok",
        isLoading: true,
      ),
    ));
    var loadingFinder = find.byType(CircularProgressIndicator);

    expect(loadingFinder, findsOneWidget);
  });
}
