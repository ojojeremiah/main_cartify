import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/modules/description/presentation/screens/description.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Description widget UI test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(home: Descriptions()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(find.byIcon(Icons.star_outlined), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Add to Cart'),
        200.0,
        scrollable: find.byType(Scrollable),
      );

      // tap button
      await tester.tap(find.text('Add to Cart'));
      await tester.pumpAndSettle();
    });
  });
}
