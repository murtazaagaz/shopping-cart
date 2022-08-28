import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/data/models/product.dart';
import 'package:manektech/presentation/bloc/cart/cart_bloc.dart';
import 'package:manektech/presentation/widgets/cart_item.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = CartBloc()..add(FetchCart());
  }

  Widget _buildBottomBar(double price, int items) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              const Text(
                'Total Items: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                items.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Grand Total: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '₹${price.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ]),
      );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartLoaded) {
              List<Product> products = state.products;

              return Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: ((context, index) =>
                            CartItem(products[index])),
                      ),
                    ),
                  ),
                  _buildBottomBar(state.total, products.length)
                ],
              );
            }
            if (state is CartEmpty) {
              return const Center(
                child: Text('No products added in cart'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
