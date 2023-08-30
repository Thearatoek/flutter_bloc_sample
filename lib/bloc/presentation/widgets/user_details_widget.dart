import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/product_cart.dart';
import '../../data/model/user_details.dart';
import '../../domain/bloc/bloc/product_bloc.dart';

class UserDetailsWidget extends StatefulWidget {
  final List<ProductModel> productlist;

  const UserDetailsWidget({Key? key, required this.productlist})
      : super(key: key);

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductAddingEvent([]));
    super.initState();
  }

  bool _switchValue = false;
  int _currentIndex = 0;
  bool isclick = false;
  final List<ProductModel> brandname = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20, bottom: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                    initialPage: 0,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        debugPrint(_currentIndex.toString());
                      });
                    },
                    height: 200.0),
                items: widget.productlist.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 5  horizontally
                                5.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                          image: DecorationImage(
                              image: NetworkImage(i.images![0]),
                              fit: BoxFit.cover),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.productlist.length,
                  (index) => _buildDotIndicator(index),
                ),
              ),
            ),
            if (state is ProductAddingState)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                          debugPrint(_switchValue.toString());

                          _switchValue
                              ? widget.productlist.map((e) {
                                  state.listproductmodel.add(e);
                                }).toList()
                              : state.listproductmodel.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: widget.productlist.map((e) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (state is ProductAddingState) {
                            if (state.listproductmodel.contains(e)) {
                              state.listproductmodel.remove(e);
                            } else {
                              state.listproductmodel.add(e);
                              debugPrint(state.listproductmodel.toString());
                            }
                          }
                        });
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Container(
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                          image: NetworkImage(e.images![0]),
                                          fit: BoxFit.cover)),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.brand.toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          "\$ ${e.price}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (state is ProductAddingState)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Center(
                                        child: state.listproductmodel
                                                .contains(e)
                                            ? GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                    Icons.check_circle_rounded))
                                            : Icon(Icons
                                                .radio_button_unchecked_outlined)),
                                  ),
                              ],
                            )),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (state is ProductAddingState)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCardDetail(
                                productdetail: state.listproductmodel,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.orange.withOpacity(0.6)),
                  child: Center(
                    child: Text('Add to cart ${state.listproductmodel.length}'),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Widget _buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: _currentIndex == index ? 6 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
