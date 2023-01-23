import 'package:flutter/material.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recomendation/features/movie_flow/result/movie.dart';

class ResultScreen extends StatefulWidget {
  static route({bool fullScreenDialog = true}) => MaterialPageRoute(
      fullscreenDialog: fullScreenDialog,
      builder: (context) => const ResultScreen());
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final double movieHeight = 150;
  final movie = const Movie(
      title: "The Hulk",
      overview: 'a quick brown fox jumps over the lazy dog...',
      voteAverage: 4.9,
      genres: [Genre(name: "Action"), Genre(name: "Fantasy")],
      releaseDate: "2019-06-12",
      backdropPath: "",
      posterPath: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CoverImage(),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: -(movieHeight / 2),
                      child: MovieImageDetails(
                          movie: movie, movieHeight: movieHeight),
                    ),
                  ],
                ),
                SizedBox(
                  height: movieHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyText2,
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
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key});

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
        child: const Placeholder(),
      ),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {super.key, required this.movie, required this.movieHeight});

  final double movieHeight;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: movieHeight,
              child: const Placeholder(),
            ),
            const SizedBox(
              width: kMediumSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: theme.textTheme.headline6),
                  Text(movie.genresCommaSeparated,
                      style: theme.textTheme.bodyText2),
                  Row(
                    children: [
                      Text(
                        "4.8",
                        style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.textTheme.bodyText2?.color
                                ?.withOpacity(0.62)),
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
