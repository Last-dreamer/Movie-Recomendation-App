import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Genre extends Equatable {
  final String name;
  final bool isSelected;
  final int id;
  const Genre({required this.name, this.isSelected = false, this.id = 0});

  Genre toggleSelected() {
    return Genre(name: name, isSelected: !isSelected, id: id);
  }

  @override
  String toString() => 'Genre(name: $name, isSelected: $isSelected, id: $id)';

  @override
  List<Object> get props => [name, isSelected, id];
}
