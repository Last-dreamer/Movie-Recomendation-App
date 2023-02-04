import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recomendation/core/failure.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recomendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recomendation/features/movie_flow/movie_service.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie_entity.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  test("Given Successful Call", () async {
    when(() => mockMovieRepository.getMovieGenres())
        .thenAnswer((invocation) => Future.value([
              const GenreEntity(id: 0, name: "Animation"),
            ]));

    final movieService = TMDBMovieService(mockMovieRepository);

    final result = await movieService.getGenres();

    expect(result.tryGetSuccess(), [const Genre(name: "Animation")]);
  });

  test("given a failure call ..", () async {
    when(() => mockMovieRepository.getMovieGenres()).thenThrow(
        Failure(message: "No Internet", exception: const SocketException('')));

    final movieService = TMDBMovieService(mockMovieRepository);
    final result = await movieService.getGenres();

    expect(result.tryGetError()?.exception, isA<SocketException>());
  });

  test("given a call for movie genre ...", () async {
    const genre = Genre(name: "Animation", id: 1, isSelected: false);

    const movieEntity = MovieEntity(
        title: "Lilo & Stich",
        overview: "Some interesting story",
        voteAverage: 4.2,
        genreIds: [1],
        releaseDate: "2010-2-3");
    when(() => mockMovieRepository.getRecommendedMovie(any(), any(), any()))
        .thenAnswer((invocation) => Future.value([movieEntity]));

    final movieService = TMDBMovieService(mockMovieRepository);
    final result = await movieService.getRecomendedMovie(5, 10, [genre],
        yearsBackFromDate: DateTime(2021));

    expect(
      result.tryGetSuccess(),
      Movie(
          title: movieEntity.title,
          overview: movieEntity.overview,
          voteAverage: movieEntity.voteAverage,
          genres: const [genre],
          releaseDate: movieEntity.releaseDate,
          backdropPath: "http://image.tmdb.org/t/p/original/",
          posterPath: "https://image.tmdb.org/t/p/original/"),
    );
  });

  test("given failure call for movies", () async {
    const genre = Genre(name: "Animation", id: 1, isSelected: false);

    when(() => mockMovieRepository.getRecommendedMovie(any(), any(), any()))
        .thenThrow(
            Failure(message: "message", exception: const SocketException("")));

    final movieService = TMDBMovieService(mockMovieRepository);
    final result = await movieService.getRecomendedMovie(5, 10, [genre],
        yearsBackFromDate: DateTime(2021));

    expect(result.tryGetError()?.exception, isA<SocketException>());
  });
}
