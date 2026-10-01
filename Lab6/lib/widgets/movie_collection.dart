import 'package:flutter/material.dart';
import 'package:lab6_responsive_ui/models/movie.dart';
import 'package:lab6_responsive_ui/widgets/movie_card.dart';

class MovieCollection extends StatelessWidget {
  const MovieCollection({required this.movies, super.key});

  static const double gridBreakpoint = 800;

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < gridBreakpoint) {
          return ListView.separated(
            key: const Key('movieList'),
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: movies.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => SizedBox(
              height: 174,
              child: MovieCard(movie: movies[index], isWide: false),
            ),
          );
        }

        return GridView.builder(
          key: const Key('movieGrid'),
          padding: const EdgeInsets.only(bottom: 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 230,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) =>
              MovieCard(movie: movies[index], isWide: true),
        );
      },
    );
  }
}
