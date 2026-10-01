import 'package:flutter/material.dart';
import 'package:lab6_responsive_ui/models/movie_sort.dart';

class ResultsToolbar extends StatelessWidget {
  const ResultsToolbar({
    required this.movieCount,
    required this.selectedSort,
    required this.showClearButton,
    required this.onSortChanged,
    required this.onClear,
    super.key,
  });

  final int movieCount;
  final MovieSort selectedSort;
  final bool showClearButton;
  final ValueChanged<MovieSort?> onSortChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final resultText = '$movieCount ${movieCount == 1 ? 'movie' : 'movies'}';
    final controls = <Widget>[
      if (showClearButton)
        TextButton.icon(
          key: const Key('clearFilters'),
          onPressed: onClear,
          icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
          label: const Text('Clear filters'),
        ),
      const SizedBox(width: 8),
      DropdownButtonHideUnderline(
        child: DropdownButton<MovieSort>(
          key: const Key('sortDropdown'),
          value: selectedSort,
          borderRadius: BorderRadius.circular(14),
          icon: const Icon(Icons.expand_more_rounded),
          items: MovieSort.values
              .map(
                (sort) => DropdownMenuItem<MovieSort>(
                  value: sort,
                  child: Text(sort.label),
                ),
              )
              .toList(),
          onChanged: onSortChanged,
        ),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final resultLabel = Text(
          resultText,
          key: const Key('resultCount'),
          style: Theme.of(context).textTheme.titleMedium,
        );
        final sortControls = Row(
          mainAxisSize: MainAxisSize.min,
          children: controls,
        );

        if (constraints.maxWidth < 430) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              resultLabel,
              const SizedBox(height: 2),
              Align(alignment: Alignment.centerRight, child: sortControls),
            ],
          );
        }

        return Row(
          children: <Widget>[resultLabel, const Spacer(), sortControls],
        );
      },
    );
  }
}
