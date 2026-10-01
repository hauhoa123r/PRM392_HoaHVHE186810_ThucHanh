import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab7/app.dart';

void main() {
  Future<void> enterValidForm(WidgetTester tester, {String? email}) async {
    await tester.enterText(find.byKey(const Key('nameField')), 'Nguyen Van A');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      email ?? 'student@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'Password1!',
    );
    await tester.enterText(find.byType(TextFormField).at(3), 'Password1!');
    await tester.ensureVisible(find.byKey(const Key('termsCheckbox')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('termsCheckbox')));
    await tester.pump();
  }

  testWidgets('renders all signup controls', (tester) async {
    await tester.pumpWidget(const SignupApp());

    expect(find.text('Create your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('I agree to the Terms & Conditions'), findsOneWidget);
  });

  testWidgets('shows required errors for an empty form', (tester) async {
    await tester.pumpWidget(const SignupApp());

    await tester.ensureVisible(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pump();

    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
    expect(find.text('Please accept the Terms & Conditions'), findsOneWidget);
  });

  testWidgets('validates password strength and confirmation', (tester) async {
    await tester.pumpWidget(const SignupApp());

    await tester.enterText(find.byKey(const Key('passwordField')), 'abcdefg');
    await tester.pump();
    expect(find.text('Weak'), findsOneWidget);
    expect(find.text('Use at least 8 characters'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'Password1!',
    );
    await tester.enterText(find.byType(TextFormField).at(3), 'Password2!');
    await tester.pump();

    expect(find.text('Strong'), findsOneWidget);
    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets('rejects an email that is already taken', (tester) async {
    await tester.pumpWidget(const SignupApp());
    await enterValidForm(tester, email: 'taken.user@example.com');

    await tester.ensureVisible(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('This email is already taken'), findsAtLeastNWidgets(1));
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('submits valid data successfully', (tester) async {
    await tester.pumpWidget(const SignupApp());
    await enterValidForm(tester);

    await tester.ensureVisible(find.byKey(const Key('submitButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(
      find.text('Account created successfully for Nguyen Van A!'),
      findsOneWidget,
    );
  });
}
