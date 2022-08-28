import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/data/models/product.dart';
import 'package:manektech/presentation/bloc/products/products_bloc.dart';
import 'package:manektech/presentation/screens/cart.dart';
import 'package:manektech/presentation/widgets/product_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProductsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = ProductsBloc()..add(FetchProducts(1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Cart()));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsLoaded) {
              List<Product> products = state.products;
              return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      childAspectRatio: .8),
                  itemBuilder: ((context, index) =>
                      ProductItem(products[index])));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
