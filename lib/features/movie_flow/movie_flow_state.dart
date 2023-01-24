import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:movie_recomendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';

const mockMovie = Movie(
    title: "The Hulk",
    overview: 'a quick brown fox jumps over the lazy dog...',
    voteAverage: 4.9,
    genres: [Genre(name: "Action"), Genre(name: "Fantasy")],
    releaseDate: "2019-06-12",
    backdropPath: "",
    posterPath: "");

const List<Genre> genresMock = [
  Genre(name: "Action"),
  Genre(name: "Comedy"),
  Genre(name: "Horror"),
  Genre(name: "Anime"),
  Genre(name: "Drama"),
  Genre(name: "Familty"),
  Genre(name: "Romance")
];

@immutable
class MovieFlowState extends Equatable {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final List<Genre> genres;
  final Movie movie;

  const MovieFlowState({
    required this.pageController,
    this.movie = mockMovie,
    this.genres = genresMock,
    this.rating = 5,
    this.yearsBack = 10,
  });

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsBack,
    List<Genre>? genres,
    Movie? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsBack: yearsBack ?? this.yearsBack,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object> get props {
    return [
      pageController,
      rating,
      yearsBack,
      genres,
      movie,
    ];
  }
}
