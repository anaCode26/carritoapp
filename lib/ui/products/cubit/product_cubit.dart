import 'package:carritoapp/shared/model/product_model.dart';
import 'package:carritoapp/shared/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({
    required this.productRepository,
  }) : super(ProductInitial());

  Future<void> getProducts() async {
    try {
      emit(ProductsLoading());
      final products = await productRepository.getProducts();
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: 'Error al obtener productos'));
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      emit(ProductsLoading());
      final products = await productRepository.searchProducts(query);

      products.isEmpty ? emit(ProductsEmpty(message: 'No se encontraron productos para $query')) : emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: 'Error al buscar productos'));
    }
  }

  Future<void> getSingleProduct(int id) async {
    try {
      emit(ProductLoading());
      final product = await productRepository.getSingleProduct(id);
      emit(ProductLoaded(product: product));
    } catch (e) {
      emit(ProductError(message: 'Error al obtener producto'));
    }
  }

  Future<void> addProductToCart(Product product) async {
    try {
      emit(ProductAddedToCartLoading());
      await productRepository.addProductToCart(product);
      emit(ProductAddedToCart());
    } catch (e) {
      emit(ProductNotAddedToCart(message: 'Error al agregar producto al carrito'));
    }
  }
}
