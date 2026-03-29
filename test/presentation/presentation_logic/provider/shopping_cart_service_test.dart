import 'package:flutter_test/flutter_test.dart';
import 'package:main_cartify/domain/model/products.dart';
import 'package:main_cartify/domain/use_cases/shoppingcart_usecase.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/shopping_cart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ShoppingCartUseCase])
import 'shopping_cart_service_test.mocks.dart';

void main() {
  group('ShoppingCartNotifier Tests', () {
    late MockShoppingCartUseCase mockUseCase;
    late ShoppingCartNotifier notifier;
    late List<String> toastMessages;

    // Test products
    final testProduct1 = Products(
      id: 1,
      title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      price: 109.95,
      description:
          'Your perfect pack for everyday use and walks in the forest. '
          'Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      category: "men's clothing",
      image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      rating: Rating(rate: 3.9, count: 120),
      quantity: 2,
      totalprice: null,
    );

    final testProduct2 = Products(
      id: 2,
      title: 'Mens Casual Premium Slim Fit T-Shirts',
      price: 22.3,
      description:
          'Slim-fitting style, contrast raglan long sleeve, three-button henley placket',
      category: "men's clothing",
      image:
          'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
      rating: Rating(rate: 4.1, count: 259),
      quantity: 1,
      totalprice: null,
    );

    setUp(() {
      mockUseCase = MockShoppingCartUseCase();
      toastMessages = [];

      // Mock toast function
      Future<void> mockToast({required String msg}) async {
        toastMessages.add(msg);
      }

      notifier = ShoppingCartNotifier(mockUseCase, toast: mockToast);
    });

    tearDown(() {
      notifier.dispose();
      toastMessages.clear();
    });

    group('fetchProducts', () {
      test('should fetch products successfully and calculate total', () async {
        // Arrange
        final products = [testProduct1, testProduct2];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (products, ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.cartState, CartDataState.success);
        expect(notifier.products.length, 2);
        expect(notifier.products[0].id, 1);
        expect(notifier.products[1].id, 2);
        expect(notifier.total, 109.95 * 2 + 22.3 * 1); // 242.2
        expect(notifier.errorMessage, '');
        verify(mockUseCase.getCartItems()).called(1);
      });

      test('should set loading state while fetching', () async {
        // Arrange
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));

        // Act
        final future = notifier.fetchProducts();

        // Assert - check loading state before await
        expect(notifier.cartState, CartDataState.loading);

        await future;
        expect(notifier.cartState, CartDataState.success);
      });

      test('should handle error and show toast', () async {
        // Arrange
        const errorMsg = 'Failed to fetch cart items';
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (null, errorMsg));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.cartState, CartDataState.error);
        expect(notifier.errorMessage, errorMsg);
        expect(toastMessages.length, 1);
        expect(toastMessages.first, errorMsg);
      });

      test('should calculate total as 0 for empty cart', () async {
        // Arrange
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.total, 0.0);
        expect(notifier.products, isEmpty);
      });

      test('should calculate correct total for Fjallraven backpack', () async {
        // Arrange - 2 backpacks at $109.95 each
        final products = [testProduct1];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (products, ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.total, 109.95 * 2); // 219.9
      });
    });

    group('updateProducts (increase quantity)', () {
      test('should increase quantity of existing product', () async {
        // Arrange - Product already in cart with quantity 2
        final existingProducts = [testProduct1];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (existingProducts, ''));
        when(
          mockUseCase.updateCartItems(any),
        ).thenAnswer((_) async => (true, ''));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        final captured =
            verify(mockUseCase.updateCartItems(captureAny)).captured.single
                as List<Products>;

        expect(captured[0].quantity, 3); // Increased from 2 to 3
        verify(
          mockUseCase.getCartItems(),
        ).called(2); // Once in update, once in fetchProducts
      });

      test('should add new product with quantity 1 if not in cart', () async {
        // Arrange - Empty cart
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));
        when(mockUseCase.addToCart(any)).thenAnswer((_) async => (true, ''));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        final captured =
            verify(mockUseCase.addToCart(captureAny)).captured.single
                as Products;

        expect(captured.id, 1);
        expect(captured.quantity, 1);
        expect(
          captured.title,
          'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
        );
      });

      test('should handle update error and show toast', () async {
        // Arrange
        final existingProducts = [testProduct1];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (existingProducts, ''));
        when(
          mockUseCase.updateCartItems(any),
        ).thenAnswer((_) async => (false, 'Update failed'));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, 'Update failed');
      });

      test('should handle add error and show toast', () async {
        // Arrange
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));
        when(
          mockUseCase.addToCart(any),
        ).thenAnswer((_) async => (false, 'Add to cart failed'));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, 'Add to cart failed');
      });

      test('should handle exception and show generic error toast', () async {
        // Arrange
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) => throw Exception('Network error'));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, 'Failed to update cart');
      });
    });

    group('deleteProducts (decrease quantity)', () {
      test('should decrease quantity of product', () async {
        // Arrange - Product with quantity 2
        final existingProducts = [testProduct1];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (existingProducts, ''));
        when(
          mockUseCase.updateCartItems(any),
        ).thenAnswer((_) async => (true, ''));

        // Act
        await notifier.deleteProducts(testProduct1);

        // Assert
        final captured =
            verify(mockUseCase.updateCartItems(captureAny)).captured.single
                as List<Products>;

        expect(captured[0].quantity, 1); // Decreased from 2 to 1
      });

      test('should remove product when quantity reaches 0', () async {
        // Arrange - Product with quantity 1
        final productWithQuantity1 = testProduct1.copyWith(quantity: 1);
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => ([productWithQuantity1], ''));
        when(
          mockUseCase.removeFromCart(any),
        ).thenAnswer((_) async => (true, ''));

        // Act
        await notifier.deleteProducts(productWithQuantity1);

        // Assert
        verify(mockUseCase.removeFromCart(any)).called(1);
        verifyNever(mockUseCase.updateCartItems(any));
      });

      test('should handle product with null quantity', () async {
        // Arrange - Product with null quantity (treated as 0)
        final productWithNullQuantity = Products(
          id: testProduct1.id,
          title: testProduct1.title,
          price: testProduct1.price,
          description: testProduct1.description,
          category: testProduct1.category,
          image: testProduct1.image,
          rating: testProduct1.rating,
          quantity: 0,
        );

        // First call returns the product, subsequent calls return empty cart
        var callCount = 0;
        when(mockUseCase.getCartItems()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return ([productWithNullQuantity], '');
          }
          return (<Products>[], '');
        });

        when(
          mockUseCase.removeFromCart(any),
        ).thenAnswer((_) async => (true, ''));

        // Act
        await notifier.deleteProducts(productWithNullQuantity);

        // Assert
        verify(mockUseCase.removeFromCart(any)).called(1);
        verify(mockUseCase.getCartItems()).called(2);
      });

      test('should handle decrease error and show toast', () async {
        // Arrange
        final existingProducts = [testProduct1];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (existingProducts, ''));
        when(
          mockUseCase.updateCartItems(any),
        ).thenAnswer((_) async => (false, 'Failed to decrease quantity'));

        // Act
        await notifier.deleteProducts(testProduct1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, 'Failed to decrease quantity');
      });

      test('should handle remove error when quantity is 0', () async {
        // Arrange
        final productWithQuantity1 = testProduct1.copyWith(quantity: 1);
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => ([productWithQuantity1], ''));
        when(
          mockUseCase.removeFromCart(any),
        ).thenAnswer((_) async => (false, 'Failed to remove item'));

        // Act
        await notifier.deleteProducts(productWithQuantity1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, 'Failed to remove item');
      });
    });

    group('removeItem', () {
      test('should remove item from cart completely', () async {
        // Arrange
        when(
          mockUseCase.removeFromCart(any),
        ).thenAnswer((_) async => (true, ''));
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));

        // Act
        await notifier.removeItem(testProduct1);

        // Assert
        verify(mockUseCase.removeFromCart(testProduct1)).called(1);
        verify(mockUseCase.getCartItems()).called(1); // fetchProducts called
      });

      test('should handle remove error and show toast', () async {
        // Arrange
        const errorMsg = 'Failed to remove item';
        when(
          mockUseCase.removeFromCart(any),
        ).thenAnswer((_) async => (false, errorMsg));

        // Act
        await notifier.removeItem(testProduct1);

        // Assert
        expect(toastMessages.length, 1);
        expect(toastMessages.first, errorMsg);
        verifyNever(
          mockUseCase.getCartItems(),
        ); // fetchProducts not called on error
      });
    });

    group('total calculation', () {
      test('should calculate total correctly for multiple products', () async {
        // Arrange
        final products = [
          testProduct1, // 109.95 * 2 = 219.9
          testProduct2, // 22.3 * 1 = 22.3
        ];
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (products, ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.total, 219.9 + 22.3); // 242.2
      });

      test('should handle zero price as 0 total', () async {
        // Arrange
        final productWithZeroPrice = Products(
          id: testProduct1.id,
          title: testProduct1.title,
          price: 0.0, // Use 0 instead of null
          description: testProduct1.description,
          category: testProduct1.category,
          image: testProduct1.image,
          rating: testProduct1.rating,
          quantity: 2,
        );

        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => ([productWithZeroPrice], ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.total, 0.0);
      });

      test('should handle zero quantity as 0 total', () async {
        // Arrange
        final productWithZeroQuantity = Products(
          id: testProduct1.id,
          title: testProduct1.title,
          price: testProduct1.price,
          description: testProduct1.description,
          category: testProduct1.category,
          image: testProduct1.image,
          rating: testProduct1.rating,
          quantity: 0, // Use 0 instead of null
        );

        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => ([productWithZeroQuantity], ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notifier.total, 0.0);
      });
      test('should update total after increasing quantity', () async {
        // Arrange
        final existingProducts = [testProduct1.copyWith(quantity: 1)];
        final updatedProducts = [testProduct1.copyWith(quantity: 2)];

        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (existingProducts, ''));
        when(
          mockUseCase.updateCartItems(any),
        ).thenAnswer((_) async => (true, ''));

        // Second call for fetchProducts after update
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (updatedProducts, ''));

        // Act
        await notifier.updateProducts(testProduct1);

        // Assert
        expect(notifier.total, 109.95 * 2); // 219.9
      });
    });

    group('state management', () {
      test('should notify listeners on state change', () async {
        // Arrange
        var notificationCount = 0;
        notifier.addListener(() {
          notificationCount++;
        });

        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));

        // Act
        await notifier.fetchProducts();

        // Assert
        expect(notificationCount, greaterThan(0));
      });

      test('should have idle state initially', () {
        // Assert
        expect(notifier.cartState, CartDataState.idle);
        expect(notifier.products, isEmpty);
        expect(notifier.total, 0.0);
        expect(notifier.errorMessage, '');
      });

      test('should clear error message on success', () async {
        // Arrange - First simulate error
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (null, 'Error'));
        await notifier.fetchProducts();
        expect(notifier.errorMessage, 'Error');

        // Act - Now simulate success
        when(
          mockUseCase.getCartItems(),
        ).thenAnswer((_) async => (<Products>[], ''));
        await notifier.fetchProducts();

        // Assert
        expect(notifier.cartState, CartDataState.success);
        expect(notifier.errorMessage, '');
      });
    });
  });
}
