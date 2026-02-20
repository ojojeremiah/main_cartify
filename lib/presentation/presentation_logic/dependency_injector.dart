import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:main_cartify/data/service/dioclient.dart';
import 'package:main_cartify/data/service/firebase_auth_service.dart';
import 'package:main_cartify/data/service/products_service.dart';
import 'package:main_cartify/data/service/shopping_cart.dart';

import 'package:main_cartify/domain/repositories/firebase_auth_service.dart';
import 'package:main_cartify/domain/repositories/products.dart';
import 'package:main_cartify/domain/repositories/shopping_cart.dart';

import 'package:main_cartify/domain/use_cases/products.dart';
import 'package:main_cartify/domain/use_cases/shoppingcart_usecase.dart';
import 'package:main_cartify/domain/use_cases/signin_usecase.dart';
import 'package:main_cartify/domain/use_cases/signout_usevase.dart';
import 'package:main_cartify/domain/use_cases/signup_usecase.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/firebase_auth_service.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/shopping_cart.dart';

final getIt = GetIt.instance;

Future<void> dependencyInjection() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductService(dioClient: getIt<DioClient>()),
  );

  getIt.registerLazySingleton<ProductUseCase>(
    () => ProductUseCase(getIt<ProductsRepository>()),
  );

  getIt.registerFactory<ProductNotifier>(
    () => ProductNotifier(getIt<ProductUseCase>()),
  );

  getIt.registerLazySingleton<FirebaseAuthServiceRepository>(
    () => FirebaseAuthServiceImpl(),
  );

  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(getIt<FirebaseAuthServiceRepository>()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<FirebaseAuthServiceRepository>()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<FirebaseAuthServiceRepository>()),
  );

  getIt.registerFactory<FirebaseAuthServiceProvider>(
    () => FirebaseAuthServiceProvider(
      getIt<SignInUseCase>(),
      getIt<SignUpUseCase>(),
      getIt<SignOutUseCase>(),
    ),
  );


  getIt.registerLazySingleton<ShoppingCartRepository>(
    () => ShoppingCartService(dioClient: getIt<DioClient>()),
  );

  getIt.registerLazySingleton<ShoppingCartUseCase>(
    () => ShoppingCartUseCase(getIt<ShoppingCartRepository>()),
  );

  getIt.registerFactory<ShoppingCartNotifier>(
    () => ShoppingCartNotifier(getIt<ShoppingCartUseCase>()),
  );
}
