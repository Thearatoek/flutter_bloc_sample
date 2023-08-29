import 'package:flutter/material.dart';

import '../logic/controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  const ProductDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final con = MyController();
  String ecrypted = '';
  @override
  void initState() {
    con.encrypt(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Encrypt and Decrypt ${widget.title}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Container(
                width: 160,
                height: 49,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.pink.withOpacity(0.6)),
                child: Center(
                    child: Text(
                  "Encrption: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  con.encryted,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    con.decrypt(con.encryted);
                  });
                },
                child: Container(
                  width: 160,
                  height: 49,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.pink.withOpacity(0.6)),
                  child: Center(
                      child: Text(
                    "Decrption: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  con.decrypted,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ],
          )),
    );
  }
}
