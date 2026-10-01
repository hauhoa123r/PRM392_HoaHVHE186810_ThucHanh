import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/network_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    required this.movie,
    required this.initiallyFavorite,
    required this.onFavoriteChanged,
    super.key,
  });

  final Movie movie;
  final bool initiallyFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _isFavorite = widget.initiallyFavorite;
  int? _userRating;

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteChanged(_isFavorite);

    _showMessage(
      _isFavorite
          ? '${widget.movie.title} added to favorites'
          : '${widget.movie.title} removed from favorites',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _chooseRating() async {
    final rating = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rate ${widget.movie.title}',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                children: [
                  for (var value = 1; value <= 5; value++)
                    IconButton.filledTonal(
                      tooltip: '$value stars',
                      onPressed: () => Navigator.pop(context, value),
                      icon: Text('$value'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (rating == null || !mounted) return;
    setState(() => _userRating = rating);
    _showMessage('You rated this movie $rating out of 5');
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 330,
            title: Text(movie.title),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: NetworkPoster(
                      imageUrl: movie.backdropUrl,
                      label: movie.title,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x22000000),
                          Color(0x22000000),
                          Color(0xE6000000),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFC857),
                              size: 21,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.rating.toStringAsFixed(1)}  •  ${movie.year}',
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final genre in movie.genres)
                            Chip(
                              label: Text(genre),
                              side: BorderSide.none,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Overview',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie.overview,
                        style: textTheme.bodyLarge?.copyWith(height: 1.55),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ActionButton(
                            icon: _isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            label: _isFavorite ? 'Favorited' : 'Favorite',
                            isSelected: _isFavorite,
                            onPressed: _toggleFavorite,
                          ),
                          _ActionButton(
                            icon: _userRating == null
                                ? Icons.star_outline_rounded
                                : Icons.star_rounded,
                            label: _userRating == null
                                ? 'Rate'
                                : '$_userRating / 5',
                            isSelected: _userRating != null,
                            onPressed: _chooseRating,
                          ),
                          _ActionButton(
                            icon: Icons.share_outlined,
                            label: 'Share',
                            onPressed: () => _showMessage(
                              'Share link ready for ${movie.title}',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Trailers',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...movie.trailers.map(
                        (trailer) => _TrailerTile(
                          trailer: trailer,
                          onTap: () => _showMessage('Playing ${trailer.title}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSelected ? colorScheme.primary : colorScheme.onSurface;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 7),
              Text(
                label,
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrailerTile extends StatelessWidget {
  const _TrailerTile({required this.trailer, required this.onTap});

  final Trailer trailer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE9E5F0)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.play_arrow_rounded,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          trailer.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(trailer.duration),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
