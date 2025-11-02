import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/use_cases/products.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';
import 'package:mocktail/mocktail.dart';

class MockProductUseCase extends Mock implements ProductUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProductUseCase mockUseCase;
  late ProductNotifier notifier;

  setUp(() {
    mockUseCase = MockProductUseCase();

    notifier = ProductNotifier(
      mockUseCase,
      toast: ({required String msg}) async {
      },
    );
  });

  group('ProductNotifier', () {
    test('initial state should be idle with empty products', () {
      expect(notifier.productState, ProductDataState.idle);
      expect(notifier.products, isEmpty);
    });

    test('fetchProducts sets success when products are returned', () async {
      // Arrange
      final mockProducts = [
        Products(
          id: 1,
          title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
          price: 109.95,
          image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
          rating: Rating(rate: 3.9, count: 120),
          description: '',
          category: '',
          quantity: null,
          totalprice: null,
        ),
        Products(
          id: 2,
          title: 'Mens Casual Premium Slim Fit T-Shirts',
          price: 22.3,
          image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png',
          rating: Rating(rate: 4.1, count: 259),
          description: '',
          category: '',
          quantity: null,
          totalprice: null,
        ),
      ];

      when(() => mockUseCase.call()).thenAnswer((_) async => (mockProducts, ''));

      await notifier.fetchProducts();

      expect(notifier.productState, ProductDataState.success);
      expect(notifier.products.length, 2);
      verify(() => mockUseCase.call()).called(1);
    });

    test('fetchProducts sets error state when products are empty', () async {
      const errorMsg = 'No products found';
      when(() => mockUseCase.call()).thenAnswer((_) async => (<Products>[], errorMsg));

      await notifier.fetchProducts();

      expect(notifier.productState, ProductDataState.error);
      expect(notifier.errorMessage, errorMsg);
      expect(notifier.products, isEmpty);
      verify(() => mockUseCase.call()).called(1);
    });

    test('fetchProducts sets loading before success or error', () async {
      when(() => mockUseCase.call()).thenAnswer((_) async => (<Products>[], 'error'));

      final states = <ProductDataState>[];
      notifier.addListener(() {
        states.add(notifier.productState);
      });

      await notifier.fetchProducts();

      expect(states.first, ProductDataState.loading);
      expect(states.last, ProductDataState.error);
    });
  });
}
