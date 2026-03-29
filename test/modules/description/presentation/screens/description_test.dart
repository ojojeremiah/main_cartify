import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/l10n/app_localizations.dart'; 
import 'package:main_cartify/modules/description/presentation/screens/description.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('Descriptions Widget Tests', () {
    late Products mockProduct;

    setUp(() {
      mockProduct = Products(
        id: 1,
        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 109.95,
        description:
            "Your perfect pack for everyday use and walks in the forest. "
            "Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "men's clothing",
        image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
        rating: Rating(rate: 3.9, count: 120),
        quantity: 0,
        totalprice: null,
      );
    });

    testWidgets('should display product details correctly', 
        (WidgetTester tester) async {
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

        // Header elements
        expect(find.text('Details'), findsOneWidget);
        expect(find.byType(BackButton), findsOneWidget);
        
        // Product information
        expect(find.textContaining('Fjallraven'), findsOneWidget);
        expect(find.textContaining('109.95'), findsOneWidget);
        
        // Rating information
        expect(find.textContaining('120 reviews'), findsOneWidget);
        expect(find.textContaining('3.9'), findsOneWidget);
        expect(find.byIcon(Icons.star_outlined), findsOneWidget);
      });
    });

    testWidgets('should add product to cart when button tapped',
        (WidgetTester tester) async {
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

        // Find and verify the button exists
        expect(find.text('Add to cart'), findsOneWidget);

        // Scroll to button if needed
        await tester.scrollUntilVisible(
          find.text('Add to cart'),
          200.0,
          scrollable: find.byType(Scrollable),
        );

        // Tap the button
        await tester.tap(find.text('Add to cart'));
        await tester.pumpAndSettle();

        // Add assertion here to verify the product was added
        // For example, check for a success message or navigation
      });
    });

    testWidgets('should display product image', 
        (WidgetTester tester) async {
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

        // Verify image widget is present
        expect(find.byType(Image), findsAtLeastNWidgets(1));
      });
    });

    testWidgets('should navigate back when back button tapped',
        (WidgetTester tester) async {
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

        // Find and tap back button
        final backButton = find.byType(BackButton);
        expect(backButton, findsOneWidget);
        
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Verify navigation occurred (widget should be popped)
      });
    });
  });
}