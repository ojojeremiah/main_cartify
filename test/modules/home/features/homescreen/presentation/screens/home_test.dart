import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/modules/commons/Brands_widget/Brands.dart';
import 'package:main_cartify/modules/home/features/homescreen/presentation/screens/home.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  testWidgets('MainScreen shows shimmer first then Brands after delay',
      (WidgetTester tester) async {
    // Load widget inside MaterialApp
    await tester.pumpWidget(
  ScreenUtilInit(
    designSize: const Size(375, 812), // match your app’s config
    builder: (context, child) => const MaterialApp(home: MainScreen()),
  ),
);

    // 🔹 Initial: shimmer should be visible
    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.byType(Brands), findsOneWidget); // shimmer wraps Brands
    expect(find.text('Brands'), findsOneWidget);
    expect(find.text('Popular Shoes'), findsOneWidget);
    expect(find.text('Nike Air Jordan'), findsOneWidget);
    expect(find.text('New Arrivals'), findsOneWidget);

    // 🔹 Advance time by 3 seconds (duration in initState)
    await tester.pump(const Duration(milliseconds: 3000));

    // 🔹 After delay: shimmer replaced by plain Brands
    expect(find.byType(Shimmer), findsNothing);
    expect(find.byType(Brands), findsOneWidget);
  });
}
