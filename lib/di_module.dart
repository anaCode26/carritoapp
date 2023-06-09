import 'package:carritoapp/shared/repositories/auth_repository.dart';
import 'package:carritoapp/shared/repositories/http_repository.dart';
import 'package:carritoapp/shared/repositories/product_repository.dart';
import 'package:carritoapp/ui/login/cubit/auth_cubit.dart';
import 'package:carritoapp/ui/products/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> setupDependencyInjection(GetIt di) async {
  await setupRepositories(di);
  await setupCubits(di);
}

Future<void> setupRepositories(GetIt di) async {
  di.registerSingletonAsync<HTTPRepository>(() async => HTTPRepository());
  di.registerSingletonAsync<AuthRepository>(
    () async => AuthRepository(
      httpRepository: di.get<HTTPRepository>(),
    ),
    dependsOn: [
      HTTPRepository
    ],
  );
  di.registerSingletonAsync<ProductRepository>(
    () async => ProductRepository(
      httpRepository: di.get<HTTPRepository>(),
    ),
    dependsOn: [
      HTTPRepository
    ],
  );
}

Future<void> setupCubits(GetIt di) async {
  di.registerSingletonAsync<AuthCubit>(
    () async => AuthCubit(
      authRepository: di.get<AuthRepository>(),
    ),
    dependsOn: [
      AuthRepository,
    ],
  );

  di.registerSingletonAsync<ProductCubit>(
    () async => ProductCubit(
      productRepository: di.get<ProductRepository>(),
    ),
    dependsOn: [
      ProductRepository,
    ],
  );
}

Future<void> checkIfDependenciesAreInitialized(GetIt di) {
  return di.allReady();
}
