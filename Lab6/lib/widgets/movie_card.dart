import 'package:flutter/material.dart';
import 'package:lab6_responsive_ui/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, required this.isWide, super.key});

  final Movie movie;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('movie_${movie.title}'),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7E2DC)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final posterWidth = isWide
              ? (constraints.maxWidth * 0.34).clamp(124.0, 176.0)
              : 112.0;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                width: posterWidth,
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => ColoredBox(
                    color: const Color(0xFFE9E3DC),
                    child: Center(
                      child: Icon(
                        Icons.movie_outlined,
                        size: 42,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const ColoredBox(
                      color: Color(0xFFF0ECE7),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isWide ? 18 : 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.calendar_today_outlined, size: 15),
                          const SizedBox(width: 5),
                          Text('${movie.year}'),
                          const SizedBox(width: 14),
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Color(0xFFF5A623),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: movie.genres
                            .map(
                              (genre) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3EFEB),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  genre,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
