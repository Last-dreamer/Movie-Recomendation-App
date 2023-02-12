import 'package:movie_recomendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recomendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie_entity.dart';

class StubMovieRepository extends MovieRepository {
  @override
  Future<List<GenreEntity>> getMovieGenres() {
    return Future.value([const GenreEntity(id: 1, name: "Animation")]);
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovie(
      double rating, String date, String genreIds) {
    return Future.value([
      const MovieEntity(
          title: "Lilo & Stich",
          overview: "some interesting story",
          voteAverage: 5.3,
          genreIds: [1, 3, 5],
          releaseDate: "2010-02-03")
    ]);
  }
}
