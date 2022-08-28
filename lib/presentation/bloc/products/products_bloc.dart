import 'package:bloc/bloc.dart';
import 'package:manektech/data/models/product.dart';
import 'package:manektech/repositories/api_repository.dart';
import 'package:manektech/repositories/db_repository.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<FetchProducts>(fetchProducts);
    on<AddToCart>(addToCart);
  }

  fetchProducts(FetchProducts event, Emitter emit) async {
    emit(ProductsLoading());
    int page = event.page;
    List<Product> products = await ApiRepository().getProducts('$page');
    emit(ProductsLoaded(products));
  }

  addToCart(AddToCart event, Emitter emit) async {
    await DbRepository().addProducts(event.product);
  }
}
