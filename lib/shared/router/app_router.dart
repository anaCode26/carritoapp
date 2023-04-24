import 'package:carritoapp/ui/login/login_screen.dart';
import 'package:carritoapp/ui/products/products_screen.dart';
import 'package:flutter/material.dart';

const root = '/';
const productsRoute = 'products';

class AppRouter {
  static Map<String, Widget> routes = {
    root: const LoginScreen(),
    productsRoute: const ProductsScreen(),
  };

  /// Genera una ruta a partir de la ruta proporcionada.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => routes[settings.name] ?? const LoginScreen(),
    );
  }
}
