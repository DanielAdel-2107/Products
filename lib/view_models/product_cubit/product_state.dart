import 'package:task/models/product_model.dart';

abstract class ProductState  {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}
