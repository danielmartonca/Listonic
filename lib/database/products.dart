import 'dart:async';

import 'package:hive/hive.dart';
import 'package:listonic_clone/model/product.dart';

import 'package:logger/logger.dart';

import 'boxes.dart';

class Products {
  static final _log = Logger(printer: PrettyPrinter());
  static const String boxName = "productsBox";

  static Future<List<Product>> getProducts() async {
    Box box = await Boxes.getProducts();
    var _productsList = box.values.toList(growable: false).cast<Product>();
    _log.i("Got list of products from database: \n${_productsList.toString()}");
    return _productsList;
  }

  static Future<bool> addToProducts(Product dbEntry) async {
    try {
      Box box = await Boxes.getProducts();
      box.add(dbEntry);
      _log.i("Added ${dbEntry.toString()}to '$boxName'.");
      return true;
    } catch (e) {
      _log.e(e);
      return false;
    }
  }
}
