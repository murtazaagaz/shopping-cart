part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class FetchProducts extends ProductsEvent {
  final int page;
  FetchProducts(this.page);
}

class AddToCart extends ProductsEvent {
  final Product product;
  AddToCart(this.product);
}
