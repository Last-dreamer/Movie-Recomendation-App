import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow_state.dart';
import 'package:movie_recomendation/features/movie_flow/movie_service.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';

import 'genre/genre.dart';

final movieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
        (ref) {
  return MovieFlowController(
      MovieFlowState(
          pageController: PageController(),
          genres: const AsyncValue.data([]),
          movie: AsyncValue.data(Movie.initial())),
      ref.watch(movieServiceProvider));
});

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(MovieFlowState state, this._movieService) : super(state) {
    loadGenres();
  }

  final MovieService _movieService;

  void loadGenres() async {
    state = state.copyWith(genres: const AsyncValue.loading());
    final result = await _movieService.getGenres();
    // state = state.copyWith(genres: AsyncValue.data(result));

    result.when((success) {
      var updatedGenre = AsyncValue.data(success);
      state = state.copyWith(genres: updatedGenre);
    }, (error) {
      state = state.copyWith(genres: AsyncValue.error(error, StackTrace.empty));
    });
  }

  getRecommendedMovie() async {
    state = state.copyWith(movie: const AsyncValue.loading());
    final selectedGeneres = state.genres.asData?.value
            .where((e) => e.isSelected == true)
            .toList() ??
        [];

    final result = await _movieService.getRecomendedMovie(
        state.rating.toDouble(), state.yearsBack, selectedGeneres);

    // state = state.copyWith(movie: AsyncValue.data(result));

    result.when((success) {
      state = state.copyWith(movie: AsyncValue.data(success));
    }, (error) {
      state = state.copyWith(movie: AsyncValue.error(error, StackTrace.empty));
    });
  }

  void toggleSelected(Genre genre) {
    state = state.copyWith(
        genres: AsyncValue.data([
      for (final oldGenre in state.genres.asData!.value)
        if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
    ]));
  }

  void updateRating(int updatedRating) {
    state = state.copyWith(rating: updatedRating);
  }

  void updateYearsBack(int updateYearsBack) {
    state = state.copyWith(yearsBack: updateYearsBack);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      if (!state.genres.asData!.value
          .any((element) => element.isSelected == true)) {
        return;
      }
    }

    state.pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  void previousPage() {
    state.pageController.previousPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}
