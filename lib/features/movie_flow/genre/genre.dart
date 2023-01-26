import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre_entity.dart';

@immutable
class Genre extends Equatable {
  final String name;
  final bool isSelected;
  final int id;
  const Genre({required this.name, this.isSelected = false, this.id = 0});

  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(name: entity.name, id: entity.id, isSelected: false);
  }

  Genre toggleSelected() {
    return Genre(name: name, isSelected: !isSelected, id: id);
  }

  @override
  String toString() => 'Genre(name: $name, isSelected: $isSelected, id: $id)';

  @override
  List<Object> get props => [name, isSelected, id];
}
