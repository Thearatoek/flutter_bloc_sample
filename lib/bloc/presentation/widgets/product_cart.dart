import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/product_detail.dart';

import '../../data/model/user_details.dart';

// ignore: must_be_immutable
class ViewCardDetail extends StatefulWidget {
  List<ProductModel> productdetail;
  ViewCardDetail({Key? key, required this.productdetail}) : super(key: key);

  @override
  State<ViewCardDetail> createState() => _ViewCardDetailState();
}

class _ViewCardDetailState extends State<ViewCardDetail> {
  @override
  void initState() {
    super.initState();
  }

  List<ProductModel> items = [];

  void onSearch(String title) {
    final itemList = widget.productdetail
        .where((element) => element.brand!.toLowerCase().contains(title))
        .toList();
    items = itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'Carts',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: widget.productdetail.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 20),
                            width: double.infinity,
                            height: 56,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  onSearch(value);
                                  debugPrint(items.toString());
                                });
                              },
                              decoration: InputDecoration(
                                label: Text('Search Item '),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          items.isEmpty
                              ? Column(
                                  children: widget.productdetail.map((e) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailScreen(
                                                          title: e.category
                                                              .toString(),
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 120,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              e.images![0]))),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  e.brand.toString(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .add_circle_outlined),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text('1')),
                                                  Icon(Icons.remove_circle)
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.2),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                )
                              : Column(
                                  children: items.map((e) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 120,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            e.images![0]))),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                e.brand.toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.add_circle_outlined),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text('1')),
                                                Icon(Icons.remove_circle)
                                              ],
                                            )
                                          ]),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.2),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Delivery:'), Text('\$3')],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Item:'),
                          Text(widget.productdetail.length.toString())
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("Are you sure to check out now?"),
                                  content: Text("This is my message."),
                                  actions: []);
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.orange.withOpacity(0.6)),
                          child: Center(
                            child: Text(
                              'Check Out',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE0smtofy13i3pfYqDGBKiC5xD_4YSktMyXjepF7yZuHJdFGImt3qPvrq6iGqyk8m7XkM&usqp=CAU'),
            ),
    );
  }
}
