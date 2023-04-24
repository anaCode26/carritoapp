import 'package:carousel_slider/carousel_slider.dart';
import 'package:carritoapp/shared/model/product_model.dart';
import 'package:carritoapp/ui/products/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductCubit productCubit;
  late Product product;

  late bool showSpinner;

  @override
  void initState() {
    product = widget.product;
    productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getSingleProduct(product.id);
    showSpinner = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: productCubitListener,
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                  itemCount: product.images.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.6,
                    enlargeCenterPage: false,
                    clipBehavior: Clip.antiAlias,
                    enlargeFactor: 1,
                    viewportFraction: 0.5,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Center(
                      child: Image.network(product.images[index], fit: BoxFit.cover, alignment: Alignment.topCenter),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(product.description),
                const SizedBox(height: 20),
                Text('USD${product.priceWithDecimal}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                showSpinner
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () => productCubit.addProductToCart(product),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ))),
                          child: const Text('Add to cart'),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  void productCubitListener(context, state) {
    switch (state.runtimeType) {
      case ProductAddedToCartLoading:
        setState(() {
          showSpinner = true;
        });
        break;
      case ProductAddedToCart:
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Added to cart'),
          backgroundColor: Colors.green,
        ));
        break;
      case ProductNotAddedToCart:
        setState(() {
          showSpinner = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        break;
      case ProductLoaded:
        setState(() {
          product = (state as ProductLoaded).product;
        });
        break;
      case ProductError:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((state as ProductError).message)));
        break;
    }
  }
}
