import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/modules/commons/all_products/all_products.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart'; // <-- new import

// --- Mock classes ---
class MockProductNotifier extends Mock implements ProductNotifier {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProductNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockProductNotifier();

    // Default empty state
    when(() => mockNotifier.products).thenReturn([]);
    when(() => mockNotifier.fetchProducts()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductNotifier>.value(value: mockNotifier),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: AllProducts(),
        ),
      ),
    );
  }

  group('AllProducts Widget', () {
    testWidgets('calls fetchProducts on initState', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      verify(() => mockNotifier.fetchProducts()).called(1);
    });

   testWidgets('AllProducts calls fetchProducts and renders products', (WidgetTester tester) async {
    final mockProducts = [
      Products(
        id: 1,
        title: 'Backpack',
        price: 109.95,
        image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
        rating: Rating(rate: 4.5, count: 10),
        description: '',
        category: '',
        quantity: 0,
        totalprice: null,
      ),
      Products(
        id: 2,
        title: 'T-Shirt',
        price: 22.3,
        image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png',
        rating: Rating(rate: 4.0, count: 5),
        description: '',
        category: '',
        quantity: 0,
        totalprice: null,
      ),
    ];

    when(() => mockNotifier.products).thenReturn(mockProducts);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify fetchProducts called
      verify(() => mockNotifier.fetchProducts()).called(1);

      // Verify products are rendered
      expect(find.text('Backpack'), findsOneWidget);
      expect(find.text('T-Shirt'), findsOneWidget);
      expect(find.textContaining('\$ 109.95'), findsOneWidget);
      expect(find.textContaining('\$ 22.3'), findsOneWidget);

      // Verify images exist
      // expect(find.byType(Image), findsWidgets);
    });
  });

    testWidgets('renders empty grid when there are no products', (WidgetTester tester) async {
      when(() => mockNotifier.products).thenReturn([]);

      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(GestureDetector), findsNothing);
        expect(find.byType(GridView), findsOneWidget);
      });
    });
  });
}
