part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchCart extends CartEvent {}

class DeleteProduct extends CartEvent {
  final int id;
  DeleteProduct(this.id);
}
