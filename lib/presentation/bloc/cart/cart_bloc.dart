import 'package:bloc/bloc.dart';
import 'package:manektech/data/models/product.dart';
import 'package:manektech/repositories/db_repository.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  late DbRepository dbRepository;
  CartBloc() : super(CartInitial()) {
    dbRepository = DbRepository();
    on<FetchCart>(fetchCart);
    on<DeleteProduct>(deleteItemFromCart);
  }

  fetchCart(FetchCart event, Emitter emit) async {
    emit(CartLoading());
    List<Product> products = await dbRepository.getCart();
    double total = 0;
    if (products.isNotEmpty) {
      for (var element in products) {
        total += element.price;
      }
      emit(CartLoaded(total: total, products: products));
    } else {
      emit(CartEmpty());
    }
  }

  deleteItemFromCart(DeleteProduct event, Emitter emit) async {
    emit(CartLoading());
    await dbRepository.deleteItemFromCart(event.id);
    add(FetchCart());
  }
}
