import 'package:bloc/bloc.dart';
import 'package:task/models/product_model.dart';
import 'package:task/services/api_consumer.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiConsumer apiConsumer;

  ProductCubit(this.apiConsumer) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await apiConsumer.get('/products');
      final List<Product> products = (response['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterProducts({String? nameQuery}) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      if (nameQuery == null || nameQuery.isEmpty) {
        fetchProducts();
      } else {
        final filteredProducts = currentState.products.where((product) {
          final name = product.title.toLowerCase();
          final query = nameQuery.toLowerCase();
          return name.contains(query);
        }).toList();
        emit(ProductLoaded(filteredProducts));
      }
    }
  }

  void toggleFavorite(int productId) {
    final currentState = state;
    if (currentState is ProductLoaded) {
      final updatedProducts = currentState.products.map((product) {
        if (product.id == productId) {
          return product.copyWith(isFavorite: !product.isFavorite);
        }
        return product;
      }).toList();
      emit(ProductLoaded(updatedProducts));
    }
  }
}
