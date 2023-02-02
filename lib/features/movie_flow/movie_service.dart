import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/failure.dart';
import 'genre/genre.dart';

final movieServiceProvider = Provider<TMDBMovieService>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return TMDBMovieService(movieRepository);
});

abstract class MovieService {
  Future<Result<List<Genre>, Failure>> getGenres();
  Future<Result<Movie, Failure>> getRecomendedMovie(
      double rating, int yearsBack, List<Genre> genres,
      {DateTime? yearsBackFromDate, String date});
}

class TMDBMovieService extends MovieService {
  TMDBMovieService(this.movieRepository);
  MovieRepository movieRepository;

  @override
  Future<Result<List<Genre>, Failure>> getGenres() async {
    try {
      final genreEntity = await movieRepository.getMovieGenres();
      final genres = genreEntity.map((e) => Genre.fromEntity(e)).toList();
      return Success(genres);
    } on Failure catch (f) {
      return Error(f);
    }
  }

  @override
  Future<Result<Movie, Failure>> getRecomendedMovie(
      double rating, int yearsBack, List<Genre> genres,
      {DateTime? yearsBackFromDate, String? date}) async {
    try {
      final date = yearsBackFromDate ?? DateTime.now();
      final year = date.year - yearsBack;
      final genreIds = genres.map((e) => e.id).toList().join(",");
      final movieEntities = await movieRepository.getRecommendedMovie(
          rating.toDouble(), "$year-01-01", genreIds);
      final movies =
          movieEntities.map((e) => Movie.fromEntity(e, genres)).toList();

      if (movies.isEmpty) {
        return Error(Failure(message: "No movies found"));
      }

      final rnd = Random();
      final randomMovie = movies[rnd.nextInt(movies.length)];

      return Success(randomMovie);
    } on Failure catch (f) {
      return Error(f);
    }
  }
}
