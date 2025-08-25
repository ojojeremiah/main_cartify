import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/modules/authentication/features/login/presentation/screens/login.dart';

void main() {
  testWidgets('renders login form with email & password fields',
      (WidgetTester tester) async {
await tester.pumpWidget(
  ScreenUtilInit(
    designSize: const Size(375, 812), // match your app’s config
    builder: (context, child) => const MaterialApp(home: LoginPage()),
  ),
);

    expect(find.text('Login to Your Account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('aishannor41@gmail.com'), findsOneWidget);
    expect(find.text('Password'), findsNWidgets(2));
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('shows error when email and password are empty',
    (WidgetTester tester) async {

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(home: LoginPage()),
    ),
  );

  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(const Key('emailField')), '');
  await tester.enterText(find.byKey(const Key('passwordField')), '');

  // Tap the "Log In" button
  await tester.tap(find.text('Log In'));
  await tester.pump(); 

  // Expect validation messages
  expect(find.text('Email Required'), findsOneWidget);
  expect(find.text('Password Required'), findsOneWidget);
});

testWidgets('toggles password visibility when icon is tapped',
      (WidgetTester tester) async {
    // Build the widget under test
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(home: LoginPage()),
      ),
    );
    await tester.pumpAndSettle();

    // Find the inner TextField inside the password TextFormField (by key)
    final passwordFormField = find.byKey(const Key('passwordField'));
    final passwordTextField = find.descendant(
      of: passwordFormField,
      matching: find.byType(TextField),
    );

    expect(passwordTextField, findsOneWidget);

    // Initially: obscured
    var textField = tester.widget<TextField>(passwordTextField);
    expect(textField.obscureText, isTrue);

    // Tap the eye icon to toggle visibility
    // (Option A) If you kept your current Icon with no key:
    await tester.tap(find.byKey(const Key('togglePasswordVisibility')));
    await tester.pump();

    // Re-read the TextField and check it’s now visible
    textField = tester.widget<TextField>(passwordTextField);
    expect(textField.obscureText, isFalse);
  });
  
  testWidgets('does not show errors when form is valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(home: LoginPage()),
    ),
  );

  await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'mor_2314');
    await tester.enterText(find.byType(TextFormField).at(1), '83r5^_');
    await tester.tap(find.text('Log In'));
    await tester.pump();

    expect(find.text('Email Required'), findsNothing);
    expect(find.text('Password Required'), findsNothing);
  });
}
