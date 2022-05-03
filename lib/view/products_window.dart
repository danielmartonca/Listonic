import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class ProductsWindow extends StatefulWidget {
  const ProductsWindow({Key? key}) : super(key: key);

  @override
  State<ProductsWindow> createState() => _ProductsWindowState();
}

class _ProductsWindowState extends State<ProductsWindow> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Align(
            child: Center(
      child: Text("My products"),
    )));
  }
}
