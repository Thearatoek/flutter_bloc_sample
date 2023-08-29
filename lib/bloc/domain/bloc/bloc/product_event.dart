part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AllProduProductEvent extends ProductEvent {}

class LoadingEvent extends ProductEvent {}

class ToggleEvent extends ProductEvent {}

class ProductAddingEvent extends ProductEvent {
  final List<ProductModel> listproductmodel;
  ProductAddingEvent(this.listproductmodel);
}

class ProductIncreaseItemEvent extends ProductEvent {}

class SplashScreenEvent extends ProductEvent {}
