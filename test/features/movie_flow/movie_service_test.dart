import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recomendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recomendation/features/movie_flow/movie_repository.dart';
import 'package:movie_recomendation/features/movie_flow/movie_service.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  test("Given Successful Call", () async {
    when(() => mockMovieRepository.getMovieGenres())
        .thenAnswer((invocation) => Future.value([
              const GenreEntity(id: 0, name: "Animation"),
            ]));

    final movieService = TMDBMovieService(mockMovieRepository);

    final result = await movieService.getGenres();

    expect(result.tryGetSuccess(), [const GenreEntity(name: "Animation")]);
  });
}
