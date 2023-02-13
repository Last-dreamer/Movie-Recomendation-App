import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/failure.dart';
import 'package:movie_recomendation/core/widget/failure_screen.dart';
import 'package:movie_recomendation/core/widget/network_fading_image.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';

class ResultScreenAnimator extends StatefulWidget {
  const ResultScreenAnimator({super.key});

  @override
  State<ResultScreenAnimator> createState() => _ResultScreenAnimatorState();
}

class _ResultScreenAnimatorState extends State<ResultScreenAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResultScreen(animationController: animationController);
  }
}

class ResultScreen extends ConsumerWidget {
  ResultScreen({super.key, required this.animationController})
      : titleOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(0, 0.3))),
        genreOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(0.3, 0.4))),
        ratingOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(0.4, 0.6))),
        descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: animationController, curve: const Interval(0.6, 0.8))),
        buttonOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(0.8, 1)));

  final AnimationController animationController;

  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;
  final Animation<double> descriptionOpacity;
  final Animation<double> buttonOpacity;

  static route({bool fullScreenDialog = true}) => MaterialPageRoute(
      fullscreenDialog: fullScreenDialog,
      builder: (context) => const ResultScreenAnimator());

  final double movieHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        body: ref.watch(movieFlowControllerProvider).movie.when(
            data: (movie) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CoverImage(movie: movie),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              bottom: -(movieHeight / 2),
                              child: MovieImageDetails(
                                  titleOpacity: titleOpacity,
                                  genreOpacity: genreOpacity,
                                  ratingOpacity: ratingOpacity,
                                  movie: movie,
                                  movieHeight: movieHeight),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: movieHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FadeTransition(
                            opacity: descriptionOpacity,
                            child: Text(
                              movie.overview,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                      onPress: () => Navigator.pop(context),
                      text: "Find Another Movie"),
                  const SizedBox(
                    height: kMediumSpacing,
                  )
                ],
              );
            },
            error: (e, s) {
              if (e is Failure) {
                return FailureScreen(message: e.message);
              }
              return const FailureScreen(
                  message: "Something went wrong with our side .....");
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 298),
      child: ShaderMask(
        shaderCallback: (rec) {
          return LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Colors.transparent
              ]).createShader(Rect.fromLTRB(0, 0, rec.width, rec.height));
        },
        blendMode: BlendMode.dstIn,
        child: NetworkFadingImage(path: movie.backdropPath),
      ),
    );
  }
}

class MovieImageDetails extends ConsumerWidget {
  const MovieImageDetails(
      {super.key,
      required this.movie,
      required this.movieHeight,
      required this.titleOpacity,
      required this.genreOpacity,
      required this.ratingOpacity});

  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;

  final double movieHeight;
  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: movieHeight,
              child: NetworkFadingImage(path: movie.posterPath.toString()),
            ),
            const SizedBox(
              width: kMediumSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                      opacity: titleOpacity,
                      child:
                          Text(movie.title, style: theme.textTheme.headline6)),
                  FadeTransition(
                    opacity: genreOpacity,
                    child: Text(movie.genresCommaSeparated,
                        style: theme.textTheme.bodyText2),
                  ),
                  Row(
                    children: [
                      FadeTransition(
                        opacity: ratingOpacity,
                        child: Text(
                          movie.voteAverage.toString(),
                          style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.textTheme.bodyText2?.color
                                  ?.withOpacity(0.62)),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
