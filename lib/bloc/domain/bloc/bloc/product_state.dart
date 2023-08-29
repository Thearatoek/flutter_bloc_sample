part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductDetailState extends ProductState {
  final List<ProductModel> productDetail;
  ProductDetailState({required this.productDetail});
}

class LoadinState extends ProductState {}

class IsClickState extends ProductState {}

class ProductAddingState extends ProductState {
  final List<ProductModel> listproductmodel;
  ProductAddingState({required this.listproductmodel});
}

class ProductIncreaseItemState extends ProductState {
  final index;
  ProductIncreaseItemState(this.index);
}

class SplashScreenState extends ProductState {}
