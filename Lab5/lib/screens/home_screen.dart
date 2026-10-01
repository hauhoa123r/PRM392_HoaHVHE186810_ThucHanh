import 'package:flutter/material.dart';

import '../data/sample_movies.dart';
import '../models/movie.dart';
import '../widgets/network_poster.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> _favoriteMovieIds = <int>{};
  String _query = '';

  List<Movie> get _filteredMovies {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return sampleMovies;

    return sampleMovies.where((movie) {
      final searchableText = '${movie.title} ${movie.genres.join(' ')}'
          .toLowerCase();
      return searchableText.contains(query);
    }).toList();
  }

  void _setFavorite(int movieId, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        _favoriteMovieIds.add(movieId);
      } else {
        _favoriteMovieIds.remove(movieId);
      }
    });
  }

  void _openDetails(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MovieDetailScreen(
          movie: movie,
          initiallyFavorite: _favoriteMovieIds.contains(movie.id),
          onFavoriteChanged: (value) => _setFavorite(movie.id, value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movies = _filteredMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Night',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Semantics(
            label: '${_favoriteMovieIds.length} favorite movies',
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Badge(
                isLabelVisible: _favoriteMovieIds.isNotEmpty,
                label: Text('${_favoriteMovieIds.length}'),
                child: const Icon(Icons.favorite_outline_rounded),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: TextField(
                    onChanged: (value) => setState(() => _query = value),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Search movies or genres',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 8),
                  child: Text(
                    'Now showing',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: movies.isEmpty
                      ? const _EmptySearchResult()
                      : ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: _MovieCard(
                                movie: movie,
                                isFavorite: _favoriteMovieIds.contains(
                                  movie.id,
                                ),
                                onTap: () => _openDetails(movie),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    required this.movie,
    required this.isFavorite,
    required this.onTap,
  });

  final Movie movie;
  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE9E5F0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'movie-poster-${movie.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 86,
                    height: 116,
                    child: NetworkPoster(
                      imageUrl: movie.posterUrl,
                      label: movie.title,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (isFavorite)
                          Icon(
                            Icons.favorite_rounded,
                            size: 20,
                            color: colorScheme.primary,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 19,
                          color: Color(0xFFFFB547),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating.toStringAsFixed(1)}  •  ${movie.year}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      movie.genres.join('  •  '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'No movies found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text('Try another title or genre.'),
          ],
        ),
      ),
    );
  }
}
