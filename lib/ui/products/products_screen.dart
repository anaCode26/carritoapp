import 'package:carritoapp/shared/model/product_model.dart';
import 'package:carritoapp/ui/products/cubit/product_cubit.dart';
import 'package:carritoapp/ui/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/const/colors_const.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  late ProductCubit productCubit;
  late List<Product> products;

  final searchController = TextEditingController(text: '');

  @override
  void initState() {
    products = [];
    productCubit = BlocProvider.of<ProductCubit>(context);

    productCubit.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Challenge 2023'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: searchController,
              onSubmitted: (value) => productCubit.searchProducts(value),
              decoration: const InputDecoration(
                filled: true,
                fillColor: secondaryColor,
                hintText: 'Search product',
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<ProductCubit, ProductState>(
              listener: productCubitListener,
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductsEmpty) {
                  return Center(child: Text(state.message));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(product.title, style: const TextStyle(color: primaryColor)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(product.brand),
                                const SizedBox(height: 10),
                                Text(product.description),
                                const SizedBox(height: 10),
                                Text('Stock: ${product.stock}'),
                              ],
                            ),
                            trailing: Text('USD${product.priceWithDecimal}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: productCubit,
                                      child: ProductDetailsScreen(product: product),
                                    ),
                                  ),
                                )),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void productCubitListener(context, state) {
    if (state is ProductsError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
    if (state is ProductsLoaded) {
      setState(() {
        products = state.products;
      });
    }
  }
}
