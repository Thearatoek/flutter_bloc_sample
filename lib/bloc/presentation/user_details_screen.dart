import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/bloc/bloc/product_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/splash_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/user_details_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final productblock = ProductBloc();
  @override
  void initState() {
    productblock.add(AllProduProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder(
            bloc: productblock,
            builder: (BuildContext context, ProductState state) {
              if (state is SplashScreenState) {
                return SplashScreen();
              }

              if (state is ProductDetailState) {
                debugPrint("hello");
                return UserDetailsWidget(productlist: state.productDetail);
              }
              return Text('');
            }),
      ),
    );
  }
}
