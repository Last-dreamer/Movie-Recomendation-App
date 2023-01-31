import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/core/envirement_variable.dart';
import 'package:movie_recomendation/core/failure.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie_entity.dart';
import 'package:movie_recomendation/main.dart';

var movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDBMovieRespository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMovieGenres();
  Future<List<MovieEntity>> getRecommendedMovie(
      double rating, String date, String genreIds);
}

class TMDBMovieRespository implements MovieRepository {
  TMDBMovieRespository({required this.dio});
  final Dio dio;

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    try {
      var response = await dio.get("genre/movie/list",
          queryParameters: {"api_key": api, "language": "en-US"});

      final result = List<Map<String, dynamic>>.from(response.data['genres']);
      final genres = result.map((e) => GenreEntity.fromMap(e)).toList();
      return genres;
    } on DioError catch (e) {
      if (e.error == SocketException) {
        throw Failure(message: "No Internet Connection", exception: e);
      }

      throw Failure(
          message: e.response?.statusMessage ?? "Something went wrong...",
          code: e.response?.statusCode);
    }
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovie(
      double rating, String date, String genreIds) async {
    var response = await dio.get("discover/movie", queryParameters: {
      "api_key": api,
      "language": "en-US",
      "sort_by": "popularity.desc",
      "include_adult": false,
      "vote_average.gte": rating,
      "page": 1,
      "release_date/gte": date,
      "with_genre": genreIds
    });

    final result = List<Map<String, dynamic>>.from(response.data['results']);
    final movies = result.map((e) => MovieEntity.fromMap(e)).toList();

    return movies;
  }
}
