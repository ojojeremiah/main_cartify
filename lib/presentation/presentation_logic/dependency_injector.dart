import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:main_cartify/data/service/dioclient.dart';
import 'package:main_cartify/data/service/products_service.dart';
import 'package:main_cartify/domain/repositories/products.dart';
import 'package:main_cartify/domain/use_cases/products.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/products.dart';

final getIt = GetIt.instance;

Future<void> dependencyInjection() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton<ProductsRepository>(
    ProductService(dioClient: getIt<DioClient>()),
  );
  getIt.registerSingleton(ProductUseCase(getIt<ProductsRepository>()));
  getIt.registerSingleton(ProductNotifier(getIt<ProductUseCase>()));
}
