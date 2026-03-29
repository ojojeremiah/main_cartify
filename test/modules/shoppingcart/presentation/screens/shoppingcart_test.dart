import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/l10n/app_localizations.dart';
import 'package:main_cartify/modules/shoppingcart/presentation/screens/shoppingcart.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/shopping_cart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';  // ← ADD THIS
import 'package:provider/provider.dart';

@GenerateMocks([ShoppingCartNotifier])
import 'shopping_cart_test.mocks.dart';

void main() {
  group('ShoppingCart Widget Tests', () {
    late MockShoppingCartNotifier mockNotifier;

    final testProduct1 = Products(
      id: 1,
      title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      price: 109.95,
      description: 'Your perfect pack for everyday use',
      category: "men's clothing",
      image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      rating: Rating(rate: 3.9, count: 120),
      quantity: 2,
    );

    final testProduct2 = Products(
      id: 2,
      title: 'Mens Casual Premium Slim Fit T-Shirts',
      price: 22.3,
      description: 'Slim-fitting style',
      category: "men's clothing",
      image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879_.jpg',
      rating: Rating(rate: 4.1, count: 259),
      quantity: 1,
    );

    setUp(() {
      mockNotifier = MockShoppingCartNotifier();
      
      when(mockNotifier.cartState).thenReturn(CartDataState.success);
      when(mockNotifier.products).thenReturn([]);
      when(mockNotifier.total).thenReturn(0.0);
      when(mockNotifier.errorMessage).thenReturn('');
      when(mockNotifier.successMessage).thenReturn('');
      when(mockNotifier.addListener(any)).thenReturn(null);
      when(mockNotifier.removeListener(any)).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return ChangeNotifierProvider<ShoppingCartNotifier>.value(
        value: mockNotifier,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ShoppingCart(),
        ),
      );
    }

    testWidgets('should display empty cart message when cart is empty',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([]);
        when(mockNotifier.total).thenReturn(0.0);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('Your Cart is Empty'), findsOneWidget);
      });  // ← WRAP
    });

    testWidgets('should display cart items when cart has products',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1, testProduct2]);
        when(mockNotifier.total).thenReturn(242.2);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('Your Cart is Empty'), findsNothing);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops'),
            findsOneWidget);
        expect(find.text('Mens Casual Premium Slim Fit T-Shirts'), findsOneWidget);
      });
    });

    testWidgets('should display correct total price',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('\$ 219.90'), findsOneWidget);
      });
    });

    testWidgets('should display product quantity',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('2'), findsOneWidget);
      });
    });

    testWidgets('should display product rating',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('Review (3.9'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });
    });

    testWidgets('should call updateProducts when add button is tapped',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);
        when(mockNotifier.updateProducts(any))
            .thenAnswer((_) async => Future.value());

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final addButton = find.byIcon(Icons.add);
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        verify(mockNotifier.updateProducts(any)).called(1);
      });
    });

    testWidgets('should call deleteProducts when decrease button is tapped',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);
        when(mockNotifier.deleteProducts(any))
            .thenAnswer((_) async => Future.value());

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final decreaseButton = find.byIcon(Icons.remove);
        await tester.tap(decreaseButton);
        await tester.pumpAndSettle();

        verify(mockNotifier.deleteProducts(any)).called(1);
      });
    });

    testWidgets(
        'should call removeItem when decrease button is tapped and quantity is 1',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        final productWithQuantity1 = testProduct1.copyWith(quantity: 1);
        when(mockNotifier.products).thenReturn([productWithQuantity1]);
        when(mockNotifier.total).thenReturn(109.95);
        when(mockNotifier.removeItem(any))
            .thenAnswer((_) async => Future.value());

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final decreaseButton = find.byIcon(Icons.remove);
        await tester.tap(decreaseButton);
        await tester.pumpAndSettle();

        verify(mockNotifier.removeItem(any)).called(1);
      });
    });

    testWidgets('should show confirmation dialog when swiping to delete',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.drag(
          find.byType(Dismissible),
          const Offset(-500, 0),
        );
        await tester.pumpAndSettle();

        expect(find.text('Remove Item'), findsOneWidget);
        expect(find.text('Are you sure you want to remove this?'), findsOneWidget);
        expect(find.text('Yes'), findsOneWidget);
        expect(find.text('No'), findsOneWidget);
      });
    });

    testWidgets('should call removeItem when confirming delete in dialog',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);
        when(mockNotifier.removeItem(any))
            .thenAnswer((_) async => Future.value());

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.drag(
          find.byType(Dismissible),
          const Offset(-500, 0),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Yes'));
        await tester.pumpAndSettle();

        verify(mockNotifier.removeItem(any)).called(1);
      });
    });

    testWidgets('should not call removeItem when canceling delete in dialog',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.drag(
          find.byType(Dismissible),
          const Offset(-500, 0),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('No'));
        await tester.pumpAndSettle();

        verifyNever(mockNotifier.removeItem(any));
      });
    });

    testWidgets('should disable checkout button when cart is empty',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([]);
        when(mockNotifier.total).thenReturn(0.0);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final checkoutButton = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Checkout'),
        );
        expect(checkoutButton.onPressed, isNull);
      });
    });

    testWidgets('should enable checkout button when cart has items',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final checkoutButton = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Checkout'),
        );
        expect(checkoutButton.onPressed, isNotNull);
      });
    });

    testWidgets('should display product image',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final imageContainer = tester.widget<Container>(
          find.descendant(
            of: find.byType(Container),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Container &&
                  widget.decoration is BoxDecoration &&
                  (widget.decoration as BoxDecoration).image != null,
            ),
          ).first,
        );

        final decoration = imageContainer.decoration as BoxDecoration;
        final imageProvider = decoration.image!.image as NetworkImage;
        expect(imageProvider.url, contains('fakestoreapi.com'));
      });
    });

    testWidgets('should display calculated price per item',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('\$ 219.9'), findsOneWidget);
      });
    });

    testWidgets('should render multiple cart items correctly',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1, testProduct2]);
        when(mockNotifier.total).thenReturn(242.2);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(Dismissible), findsNWidgets(2));
        expect(find.byIcon(Icons.add), findsNWidgets(2));
        expect(find.byIcon(Icons.remove), findsNWidgets(2));
      });
    });

    testWidgets('should show delete icon in dismissible background',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {  // ← WRAP
        when(mockNotifier.products).thenReturn([testProduct1]);
        when(mockNotifier.total).thenReturn(219.90);

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        await tester.drag(
          find.byType(Dismissible),
          const Offset(-100, 0),
        );
        await tester.pump();

        expect(find.byIcon(Icons.delete_outline), findsOneWidget);
      });
    });
  });
  }