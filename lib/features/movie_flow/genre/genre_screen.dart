import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recomendation/core/constants.dart';
import 'package:movie_recomendation/core/widget/primary_button.dart';
import 'package:movie_recomendation/features/movie_flow/genre/list_card.dart';
import 'package:movie_recomendation/features/movie_flow/movie_flow_controller.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:
              ref.read(movieFlowControllerProvider.notifier).previousPage,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Let's start with genre", style: theme.textTheme.headline5),
            Expanded(
                child: ref.watch(movieFlowControllerProvider).genres.when(
                    data: (genres) {
                      return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              vertical: kListItemSpacing),
                          itemBuilder: (context, index) {
                            var genre = genres[index];

                            return ListCard(
                              genre: genre,
                              onTap: () => ref
                                  .read(movieFlowControllerProvider.notifier)
                                  .toggleSelected(genre),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: kListItemSpacing,
                            );
                          },
                          itemCount: genres.length);
                    },
                    error: (e, s) => const Center(
                          child: Text("an error occured"),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ))),
            PrimaryButton(
                onPress:
                    ref.read(movieFlowControllerProvider.notifier).nextPage,
                text: "Continue"),
            const SizedBox(
              height: kMediumSpacing,
            )
          ],
        ),
      ),
    );
  }
}
