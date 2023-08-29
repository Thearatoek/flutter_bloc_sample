import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/user_details.dart';
import '../../../data/repository/user_details_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    on<AllProduProductEvent>(_productdetailData);
    on<LoadingEvent>(_loadingfetchdata);
    on<ProductAddingEvent>(_onAddingProduct);
    on<ProductIncreaseItemEvent>(_onIncreaseItem);
    on<SplashScreenEvent>(_onSplashScreen);
  }
  final repository = ProductDetailReposity();

  void _productdetailData(
      ProductEvent event, Emitter<ProductState> emit) async {
    try {
      add(SplashScreenEvent());
      await Future.delayed(Duration(seconds: 3), () {
        add(LoadingEvent());
      });

      final datalist = await repository.fetchUserDetails();
      emit(ProductDetailState(productDetail: datalist));
    } catch (e) {}
  }

  void _loadingfetchdata(
      ProductDetailEvent event, Emitter<ProductDetailsState> emit) {
    emit(LoadinState());
  }

  void _onAddingProduct(
      ProductAddingEvent event, Emitter<ProductDetailsState> emit) {
    final List<ProductModel> listingn = [];
    emit(ProductAddingState(listproductmodel: listingn));
  }

  void _onIncreaseItem(
      ProductIncreaseItemEvent event, Emitter<ProductDetailsState> emit) {
    final int index = 0;
    emit(ProductIncreaseItemState(index));
  }

  void _onSplashScreen(
      SplashScreenEvent event, Emitter<ProductDetailsState> emit) {
    emit(SplashScreenState());
  }
}
