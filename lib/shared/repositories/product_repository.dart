import 'package:carritoapp/shared/const/endpoints_const.dart';
import 'package:carritoapp/shared/model/product_model.dart';
import 'package:carritoapp/shared/repositories/http_repository.dart';

class ProductRepository {
  final HTTPRepository httpRepository;

  ProductRepository({
    required this.httpRepository,
  });

  Future<List<Product>> getProducts() async {
    final response = await httpRepository.get(
      '$baseUrl$productsEndpoint',
    );

    return Product.fromJsonList(response.data['products']);
  }

  Future<Product> getSingleProduct(int id) async {
    final response = await httpRepository.get(
      '$baseUrl$productsEndpoint/$id',
    );

    return Product.fromJson(response.data);
  }

  Future<List<Product>> searchProducts(String keyword) async {
    final response = await httpRepository.get(
      '$baseUrl$productsByKeywordEndpoint',
      queryParameters: {
        'q': keyword,
      },
    );

    return Product.fromJsonList(response.data['products']);
  }

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
