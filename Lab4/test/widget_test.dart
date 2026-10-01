import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_flutter_ui/main.dart';

void main() {
  testWidgets('launcher displays all five exercises', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lab 4 - Flutter UI Fundamentals'), findsOneWidget);
    expect(find.textContaining('Exercise 1'), findsOneWidget);
    expect(find.textContaining('Exercise 2'), findsOneWidget);
    expect(find.textContaining('Exercise 3'), findsOneWidget);
    expect(find.textContaining('Exercise 4'), findsOneWidget);
    expect(find.textContaining('Exercise 5'), findsOneWidget);
  });

  testWidgets('can open the input controls and update a switch', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.textContaining('Exercise 2'));
    await tester.pumpAndSettle();
    expect(find.text('Current value: 50'), findsOneWidget);
    expect(find.text('Status: Inactive'), findsOneWidget);

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();
    expect(find.text('Status: Active'), findsOneWidget);
  });
}
