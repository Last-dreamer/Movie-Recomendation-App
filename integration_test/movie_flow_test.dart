import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';
import 'package:movie_recomendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recomendation/features/movie_flow/rating/rating_screen.dart';
import 'package:movie_recomendation/main.dart';

import 'stubs/stub_movie_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("a test to generate fake data at the end ",
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      movieRepositoryProvider.overrideWithValue(StubMovieRepository())
    ], child: const MyApp()));

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Animation"));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    expect(find.text('Lilo & Stich'), findsOneWidget);
  });

  testWidgets("a test to check if genre is not selected then ....",
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      movieRepositoryProvider.overrideWithValue(StubMovieRepository()),
    ], child: const MyApp()));

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PrimaryButton));

    // expect(find..byType(RatingScreen), findsOneWidget);
  });
}
