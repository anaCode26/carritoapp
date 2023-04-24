import 'package:intl/intl.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final num discountPercentage;
  final num rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  /// Convierte un json en un objeto de tipo producto
  ///
  /// * [json] es un json que contiene los datos de un producto
  /// * Retorna un objeto de tipo producto
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }

  /// Convierte una lista de jsons en una lista de productos
  ///
  /// * [jsonList] es una lista de jsons que contiene los datos de los productos
  /// * Retorna una lista de productos
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  /// Retorna el precio con dos decimales y reemplaza el punto por una coma
  ///
  /// * Retorna un string con el precio
  /// * Ejemplo: 1,00.00 => 1.000,00
  get priceWithDecimal => NumberFormat.currency(locale: 'es', symbol: '').format(price);
}
