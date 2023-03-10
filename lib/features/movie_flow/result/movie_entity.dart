import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final String overview;
  final num voteAverage;
  final List<int> genreIds;
  final String releaseDate;
  final String backdropPath;
  final String posterpath;
  const MovieEntity({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genreIds,
    required this.releaseDate,
    this.backdropPath = "",
    this.posterpath = "",
  });

  MovieEntity copyWith({
    String? title,
    String? overview,
    num? voteAverage,
    List<int>? genreIds,
    String? releaseDate,
    String? backdropPath,
    String? posterpath,
  }) {
    return MovieEntity(
      title: title ?? this.title,
      overview: overview ?? this.overview,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      releaseDate: releaseDate ?? this.releaseDate,
      backdropPath: backdropPath ?? this.backdropPath,
      posterpath: posterpath ?? this.posterpath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'overview': overview,
      'voteAverage': voteAverage,
      'genreIds': genreIds,
      'releaseDate': releaseDate,
      'backdropPath': backdropPath,
      'posterpath': posterpath,
    };
  }

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    log("testing map ${map['poster_path']}");
    return MovieEntity(
      title: map['title'] ?? '',
      overview: map['overview'] ?? '',
      voteAverage: map['vote_average'] ?? 0,
      genreIds: List<int>.from(map['genre_ids']),
      releaseDate: map['release_date'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      posterpath: map['poster_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieEntity.fromJson(String source) =>
      MovieEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieEntity(title: $title, overview: $overview, voteAverage: $voteAverage, genreIds: $genreIds, releaseDate: $releaseDate, backdropPath: $backdropPath, posterpath: $posterpath)';
  }

  @override
  List<Object> get props {
    return [
      title,
      overview,
      voteAverage,
      genreIds,
      releaseDate,
      backdropPath,
      posterpath,
    ];
  }
}
