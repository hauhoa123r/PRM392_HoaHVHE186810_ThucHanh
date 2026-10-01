import 'package:flutter/material.dart';

/// Exercise 3: combines Column, Row, Padding, SizedBox and ListView.builder.
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  static const movies = [
    ('Avatar', 'Science fiction adventure'),
    ('Inception', 'Dreams within dreams'),
    ('Interstellar', 'A journey beyond the stars'),
    ('Joker', 'Psychological drama'),
    ('The Dark Knight', 'Superhero crime thriller'),
    ('Parasite', 'Comedy, drama and suspense'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 - Layout Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_movies_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Now Playing',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Expanded gives the ListView a finite height inside the Column.
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          child: Text(movie.$1.substring(0, 1)),
                        ),
                        title: Text(movie.$1),
                        subtitle: Text(movie.$2),
                        trailing: const Icon(Icons.play_circle_outline),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
