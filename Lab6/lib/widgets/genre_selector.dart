import 'package:flutter/material.dart';

class GenreSelector extends StatelessWidget {
  const GenreSelector({
    required this.genres,
    required this.selectedGenres,
    required this.onGenreSelected,
    super.key,
  });

  final List<String> genres;
  final Set<String> selectedGenres;
  final ValueChanged<String> onGenreSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Genres', style: Theme.of(context).textTheme.titleMedium),
            if (selectedGenres.isNotEmpty) ...<Widget>[
              const SizedBox(width: 8),
              Container(
                key: const Key('genreBadge'),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '${selectedGenres.length} selected',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: genres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return FilterChip(
              key: Key('genre_$genre'),
              label: Text(genre),
              selected: isSelected,
              showCheckmark: true,
              onSelected: (_) => onGenreSelected(genre),
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFFDAD4CD),
              ),
              backgroundColor: Colors.white,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              shape: const StadiumBorder(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
