part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final double total;
  final List<Product> products;
  CartLoaded({
    required this.total,
    required this.products,
  });
}

class CartEmpty extends CartState {}
