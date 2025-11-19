import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/l10n/app_localizations.dart'; // <- real localization
import 'package:main_cartify/modules/description/presentation/screens/description.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Descriptions widget UI test', (WidgetTester tester) async {
    final mockProduct = Products(
      id: 1,
      title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      price: 109.95,
      description:
          "Your perfect pack for everyday use and walks in the forest. "
          "Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      category: "men's clothing",
      image:
          "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
      rating: Rating(rate: 3.9, count: 120),
      quantity: null,
      totalprice: null,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Descriptions(products: mockProduct),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Details'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.textContaining('Fjallraven'), findsOneWidget);
      expect(find.textContaining('109.95'), findsOneWidget);
      expect(find.textContaining('120 reviews'), findsOneWidget);
      expect(find.textContaining('3.9'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(find.byIcon(Icons.star_outlined), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Add to Cart'),
        200.0,
        scrollable: find.byType(Scrollable),
      );
      await tester.tap(find.text('Add to Cart'));
      await tester.pumpAndSettle();
    });
  });
}
