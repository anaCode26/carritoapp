part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

// Estados para obtener una lista de productos
class ProductsInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsEmpty extends ProductState {
  final String message;

  ProductsEmpty({
    required this.message,
  });
}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded({
    required this.products,
  });
}

class ProductsError extends ProductState {
  final String message;

  ProductsError({
    required this.message,
  });
}

// Estados para obtener un solo producto
class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  ProductLoaded({
    required this.product,
  });
}

class ProductError extends ProductState {
  final String message;

  ProductError({
    required this.message,
  });
}

// Estados para agregar un producto al carrito
class ProductAddedToCartLoading extends ProductState {}

class ProductAddedToCart extends ProductState {}

class ProductNotAddedToCart extends ProductState {
  final String message;

  ProductNotAddedToCart({
    required this.message,
  });
}
