import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recomendation/features/movie_flow/movie_service.dart';
import 'package:multiple_result/multiple_result.dart';

class MockedMovieService extends Mock implements MovieService {}

void main() {
  late MovieService mockedMovieService;
  late ProviderContainer container;
  late Genre genre;

  setUp(() {
    mockedMovieService = MockedMovieService();
    container = ProviderContainer(overrides: [
      movieServiceProvider.overrideWithValue(mockedMovieService)
    ]);
    genre = const Genre(name: "Animation");
    when(() => mockedMovieService.getGenres())
        .thenAnswer((invocation) => Future.value(Success([genre])));
  });

  tearDown(() {
    container.dispose();
  });

  group("movieFlowController -", () {
    test("geven genres", () async {
      await container
          .read(movieFlowControllerProvider.notifier)
          .stream
          .firstWhere((e) => e.genres is AsyncData);

      container
          .read(movieFlowControllerProvider.notifier)
          .toggleSelected(genre);

      var toggleGenre = genre.toggleSelected();
      expect(container.read(movieFlowControllerProvider).genres.value,
          [toggleGenre]);
    });

    for (var rating in [0, 2, 4, -2]) {
      test("given test for $rating in rating", () async {
        container
            .read(movieFlowControllerProvider.notifier)
            .updateRating(rating);

        expect(container.read(movieFlowControllerProvider).rating, rating);
      });
    }

    for (var yearBack in [0, 2, 14, 10, -2]) {
      test("given yearback $yearBack in yearsBack", () async {
        container
            .read(movieFlowControllerProvider.notifier)
            .updateYearsBack(yearBack);

        expect(container.read(movieFlowControllerProvider).yearsBack, yearBack);
      });
    }

    test("given call for recommended movie", () async {
      //  todo this tommorow ....
      container
          .read(movieFlowControllerProvider.notifier)
          .getRecommendedMovie();
    });
  });
}
