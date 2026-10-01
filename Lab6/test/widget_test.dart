import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_responsive_ui/app/responsive_movie_app.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(600, 900),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pump();
  }

  testWidgets('shows the responsive movie browser', (tester) async {
    await pumpApp(tester);

    expect(find.text('Find a Movie'), findsOneWidget);
    expect(find.byKey(const Key('searchField')), findsOneWidget);
    expect(find.byKey(const Key('movieList')), findsOneWidget);
    expect(find.text('8 movies'), findsOneWidget);
  });

  testWidgets('filters movies by title and shows an empty state', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.enterText(find.byKey(const Key('searchField')), 'inception');
    await tester.pump();

    expect(find.text('1 movie'), findsOneWidget);
    expect(find.text('Inception'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('searchField')), 'not a movie');
    await tester.pump();

    expect(find.byKey(const Key('emptyState')), findsOneWidget);
    expect(find.text('0 movies'), findsOneWidget);
  });

  testWidgets('filters movies by genre and clears filters', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('genre_Animation')));
    await tester.pump();

    expect(find.text('2 movies'), findsOneWidget);
    expect(find.byKey(const Key('genreBadge')), findsOneWidget);

    await tester.tap(find.byKey(const Key('clearFilters')));
    await tester.pump();

    expect(find.text('8 movies'), findsOneWidget);
    expect(find.byKey(const Key('genreBadge')), findsNothing);
  });

  testWidgets('uses a two-column grid on wide screens', (tester) async {
    await pumpApp(tester, size: const Size(1000, 900));

    expect(find.byKey(const Key('movieGrid')), findsOneWidget);
    expect(find.byKey(const Key('movieList')), findsNothing);
  });
}
