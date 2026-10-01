import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_detail_app/main.dart';

void main() {
  testWidgets('filters movies and displays an empty state', (tester) async {
    await tester.pumpWidget(const MovieDetailApp());

    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'animation');
    await tester.pump();

    expect(find.textContaining('Animation'), findsOneWidget);
    expect(find.text('Dune: Part Two'), findsNothing);

    await tester.enterText(find.byType(TextField), 'not a movie');
    await tester.pump();

    expect(find.text('No movies found'), findsOneWidget);
  });

  testWidgets('passes a movie to the detail screen and toggles favorite', (
    tester,
  ) async {
    await tester.pumpWidget(const MovieDetailApp());

    await tester.tap(find.text('Dune: Part Two'));
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Official Trailer #1'), findsOneWidget);

    await tester.ensureVisible(find.text('Favorite'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorite'));
    await tester.pump();
    expect(find.text('Favorited'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
  });
}
