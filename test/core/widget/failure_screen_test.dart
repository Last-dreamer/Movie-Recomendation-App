import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_recomendation/core/widget/failure_screen.dart';

void main() {
  testWidgets('failure screen ...', (tester) async {
    const message = "no";
    await tester
        .pumpWidget(const MaterialApp(home: FailureScreen(message: message)));

    expect(find.text(message), findsOneWidget);
  });
}
