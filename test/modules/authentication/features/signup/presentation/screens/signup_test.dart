import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/modules/authentication/features/login/presentation/screens/login.dart';
import 'package:main_cartify/modules/authentication/features/signup/presentation/screens/signup.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Signup Widget Tests", () {
    testWidgets("renders Signup screen correctly", (WidgetTester tester) async {
      await tester.pumpWidget(
  ScreenUtilInit(
    designSize: const Size(375, 812), // match your app’s config
    builder: (context, child) => const MaterialApp(home: Signup()),
  ),
);

      expect(find.text("Create an Account"), findsOneWidget);
      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('passwordField')), findsOneWidget);
      expect(find.text("Sign up"), findsOneWidget);
    });

    testWidgets("shows validation error when fields are empty",
        (WidgetTester tester) async {
      await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(home: Signup()),
    ),
  );

      await tester.tap(find.text("Sign up"));
      await tester.pump();

      expect(find.text("Email Required"), findsOneWidget);
      expect(find.text("Password Required"), findsOneWidget);
    });

    testWidgets("toggles password visibility",
        (WidgetTester tester) async {
      await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(home: Signup()),
      ),
    );
    await tester.pumpAndSettle();
      final passwordFormField = find.byKey(const Key('passwordField'));
    final passwordTextField = find.descendant(
      of: passwordFormField,
      matching: find.byType(TextField),
    );

    expect(passwordTextField, findsOneWidget);

      // Initially password field should be obscured
      var textField = tester.widget<TextField>(passwordTextField);
    expect(textField.obscureText, isTrue);

      // Tap toggle icon
      await tester.tap(find.byKey(const Key('togglePasswordVisibility')));
      await tester.pump();

     
    });

    testWidgets("navigates to LoginPage on Login button tap",
        (WidgetTester tester) async {
      await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(home: LoginPage()),
    ),
      );

      await tester.tap(find.text("Sign up"));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
