import 'package:carritoapp/shared/const/endpoints_const.dart';
import 'package:carritoapp/shared/model/product_model.dart';
import 'package:carritoapp/shared/repositories/http_repository.dart';

class ProductRepository {
  final HTTPRepository httpRepository;

  ProductRepository({
    required this.httpRepository,
  });

  /// Obtiene todos los productos y retorna una lista de productos
  Future<List<Product>> getProducts() async {
    final response = await httpRepository.get(
      '$baseUrl$productsEndpoint',
    );

    return Product.fromJsonList(response.data['products']);
  }

  /// Obtiene un producto por su id y retorna un objeto de tipo producto
  Future<Product> getSingleProduct(int id) async {
    final response = await httpRepository.get(
      '$baseUrl$productsEndpoint/$id',
    );

    return Product.fromJson(response.data);
  }

  /// Obtiene todos los productos que coincidan con la búsqueda y retorna una lista de productos
  Future<List<Product>> searchProducts(String keyword) async {
    final response = await httpRepository.get(
      '$baseUrl$productsByKeywordEndpoint',
      queryParameters: {
        'q': keyword,
      },
    );

    return Product.fromJsonList(response.data['products']);
  }

  /// Agrega un producto al carrito.
  Future addProductToCart(Product product) async {
    return await httpRepository.post(
      '$baseUrl$addCartEndpoint',
      data: {
        "userId": 1,
        "products": [
          {
            "id": product.id,
            "quantity": 1
          }
        ]
      },
    );
  }
}
